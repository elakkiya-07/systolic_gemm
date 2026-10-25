# Systolic GEMM Accelerator on PYNQ-Z2

A 3×3 output-stationary systolic array for matrix multiplication (GEMM), written in
Vitis HLS with an AXI4-Stream interface and verified in C and C/RTL co-simulation
against a NumPy golden reference. Target: PYNQ-Z2 (Zynq-7020, `xc7z020clg400-1`).

```
C = A × B        A, B : 3×3 fixed-point      C : 3×3 fixed-point
```

---

## Architecture

Nine processing elements (PEs) run as concurrent DATAFLOW processes and talk only to
their neighbours through FIFO streams. Rows of **A** enter from the left, columns of
**B** enter from the top. Each PE multiplies, accumulates locally, and forwards `a` to
the right and `b` downward. After N = 3 steps, every PE emits its own `C[i][j]`.

```
            B[k][0]   B[k][1]   B[k][2]
               │         │         │
               ▼         ▼         ▼
A[0][k] ──► PE(0,0) ─► PE(0,1) ─► PE(0,2) ─► sink
               │         │         │
               ▼         ▼         ▼
A[1][k] ──► PE(1,0) ─► PE(1,1) ─► PE(1,2) ─► sink
               │         │         │
               ▼         ▼         ▼
A[2][k] ──► PE(2,0) ─► PE(2,1) ─► PE(2,2) ─► sink
               │         │         │
               ▼         ▼         ▼
             sink      sink      sink

Each PE(i,j):  acc += a × b   (N times)  →  C[i][j]
```

| Process | Role |
|---|---|
| `feed_A` | Pushes column *k* of A into the left edge of every row at step *k* |
| `feed_B` | Pushes row *k* of B into the top edge of every column at step *k* |
| `pe` (×9) | Reads `a`, `b`; MAC into a local accumulator; forwards `a` right, `b` down |
| `sink_A`, `sink_B` | Drain values leaving the right and bottom edges, so the FIFOs never block |
| `collect` | Reads each PE's one-shot result stream into `C` |

The top level streams A and B in off AXI4-Stream, buffers them, runs the systolic core,
then streams C back out (TLAST on the final element).

**Dataflow:** output-stationary (each `C[i][j]` stays in its PE until done).

---

## Data types

Defined in `og_systolic_gemm.h`:

| Type | Definition | Integer / fraction bits | Range | Resolution |
|---|---|---|---|---|
| `data_t` | `ap_fixed<16,8>` | 8 / 8 | −128 to +127.996 | 2⁻⁸ ≈ 0.0039 |
| `acc_t` | `ap_fixed<32,16>` | 16 / 16 | ≈ ±32768 | 2⁻¹⁶ |
| `axis_t` | `ap_axis<32,0,0,0>` | — | 32-bit AXI4-Stream word (TDATA + TLAST/TKEEP/TSTRB) |

**Accumulator sizing:** inputs are carried in the low 16 bits of each 32-bit stream word;
the full 32-bit accumulator is streamed back out. For the demonstrated operand range the
three-term dot product stays well inside ±32768 (default wrap-around mode). For
near-full-scale operands, enable `AP_SAT` or widen the integer field.

---

## HLS directives used

| Directive | Where | Effect |
|---|---|---|
| `DATAFLOW` | systolic core | Feeders, 9 PEs, sinks and collector run concurrently |
| `UNROLL` | ROW / COL loops | Instantiates 9 physical PEs |
| `PIPELINE II=1` | every inner loop | One operand pair per clock per PE |
| `BIND_OP op=mul impl=dsp` | PE multiply | Forces each multiply onto a DSP48E1 slice (16×16 fits one 25×18 DSP) |
| `ARRAY_PARTITION complete` | stream / buffer arrays | Separate FIFO/register per PE link |
| `STREAM depth=4 / 2` | a,b / c streams | FIFO depths between processes |
| `INTERFACE axis` | in_A, in_B, out_C | AXI4-Stream data ports |

---

## Interface

Data moves over **AXI4-Stream**; only the control handshake is AXI4-Lite.

| Port | Type | Direction | Description |
|---|---|---|---|
| `in_A` | AXI4-Stream (`axis_t`) | in | 9 beats, A row-major (16-bit operand in low bits) |
| `in_B` | AXI4-Stream (`axis_t`) | in | 9 beats, B row-major |
| `out_C` | AXI4-Stream (`axis_t`) | out | 9 beats, C row-major, TLAST on last |
| `return` | AXI4-Lite (`CTRL`) | ctrl | `ap_start` / `ap_done` / `ap_idle` |

AXI4-Stream pairs with AXI DMA on the PS side. For much larger N, add tiling and/or
`m_axi` (direct DDR access).

---

## Repository structure

```
├── src/
│   ├── og_systolic_gemm.h     # N, data_t, acc_t, axis_t, top-level prototype
│   └── og_systolic_gemm.cpp   # PE, feeders, sinks, collector, systolic core, top level
├── tb/
│   └── tb_og_systolic_gemm.cpp # C-sim / co-sim testbench (streams in A,B; checks C)
├── hw/                         # (pending board build) .bit + .hwh, same base name
├── notebooks/                  # (pending) PYNQ DMA bring-up + NumPy comparison
└── docs/                       # screenshots: HLS report, timing, resource estimates
```

---

## Build flow

1. **Vitis HLS:** C simulation → C synthesis → C/RTL co-simulation → Export RTL (IP).
   Top function `og_systolic_gemm`, part `xc7z020clg400-1`, 10 ns clock.
2. **Vivado:** Block design with Zynq-7000 PS (PYNQ-Z2 preset) + the exported IP, with
   **AXI DMA** engines driving `in_A`/`in_B` and capturing `out_C` → generate bitstream.
3. **Files to board:** copy the `.bit` and `.hwh` with the **same base name** into one
   folder on the PYNQ-Z2.

## Running on PYNQ-Z2 (planned, DMA-based)

1. Load the overlay with `pynq.Overlay("<name>.bit")`.
2. Allocate contiguous buffers with `pynq.allocate` (int16 in, int32 out).
3. Scale inputs: real value × 2⁸ for `ap_fixed<16,8>`.
4. `dma.sendchannel.transfer(buf_A)` / `transfer(buf_B)`, `dma.recvchannel.transfer(buf_C)`.
5. Read C back and divide by 2¹⁶ (for `ap_fixed<32,16>`).
6. Compare with `numpy.matmul(A, B)`.

*(On-board bring-up not yet completed; functional correctness is verified in
C/RTL co-simulation.)*

---

## Results (post-synthesis, Vitis HLS 2025.2)

| Metric | Value | Available |
|---|---|---|
| Target clock | 10.00 ns | — |
| Estimated clock | 7.299 ns (**≈137 MHz**) | — |
| Latency | ≈46 cycles end-to-end (≈17-cycle compute core) | — |
| DSP48E1 | **9** (4.1%) | 220 |
| LUT | **5,604** (10.5%) | 53,200 |
| FF | **5,453** (5.1%) | 106,400 |
| BRAM | **0** | 140 |
| Correctness | matches NumPy golden in C/RTL co-sim | — |
| Hardware vs ARM (NumPy) | not yet measured (board bring-up pending) | — |

---

## Limitations and next steps

- Fixed 3×3; larger matrices need tiling or a larger N within the 220-DSP budget.
- On-board DMA bring-up and an ARM-vs-FPGA timing comparison are the next steps.
- Unskewed, buffered feeding; a streaming/skewed feed would overlap I/O with compute.
- Accumulator uses default wrap mode; add `AP_SAT` if N or input range grows.
- Implementation using Bluespec SystemVerilog
## Tools

Vitis HLS · Vivado · PYNQ · Python / NumPy · PYNQ-Z2 (Zynq-7020)
