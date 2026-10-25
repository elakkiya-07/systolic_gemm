# Systolic GEMM Accelerator on PYNQ-Z2

A 3×3 output-stationary systolic array for matrix multiplication (GEMM), written in Vitis HLS and verified on the PYNQ-Z2 (Zynq-7020) against NumPy.

```
C = A × B        A, B : 3×3 fixed-point      C : 3×3 fixed-point
```

---

## Architecture

Nine processing elements (PEs) run as concurrent DATAFLOW processes and talk only to their neighbours through FIFO streams. Rows of **A** enter from the left, columns of **B** enter from the top. Each PE multiplies, accumulates locally, and forwards `a` to the right and `b` downward. After N = 3 steps, every PE emits its own `C[i][j]`.

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

**Dataflow:** output-stationary (each `C[i][j]` stays in its PE until done).
**Feeding:** uniform (unskewed) per step: a classic synchronous systolic schedule.

---

## Data types

Defined in `gemm.h`:

| Type | Definition | Integer / fraction bits | Range | Resolution |
|---|---|---|---|---|
| `data_t` | `ap_fixed<16,6>` | 6 / 10 | −32 to +31.999 | 2⁻¹⁰ ≈ 0.001 |
| `acc_t` | `ap_fixed<32,14>` | 14 / 18 | ≈ ±8192 | 2⁻¹⁸ |

**Accumulator sizing:** the largest product is 32 × 32 = 1,024; summing N = 3 products gives at most 3,072, well inside ±8,192, so the accumulator cannot overflow. (Earlier version used `ap_fixed<40,12>`; reduced to 32 bits as right-sized.)

---

## HLS directives used

| Directive | Where | Effect |
|---|---|---|
| `DATAFLOW` | top level | Feeders, 9 PEs, sinks and collector run concurrently |
| `UNROLL` | ROW / COL loops | Instantiates 9 physical PEs |
| `PIPELINE II=1` | every inner loop | One operand pair per clock per PE |
| `BIND_OP op=mul impl=dsp` | PE multiply | Forces each multiply onto a DSP48E1 slice (16×16 fits one 25×18 DSP) |
| `ARRAY_PARTITION complete` | stream arrays | Separate FIFO per PE link |
| `STREAM depth=4 / 2` | a,b / c streams | FIFO depths between processes |

---

## Interface

All ports are **AXI4-Lite** in one bundle (`CTRL`):

| Port | Direction | Description |
|---|---|---|
| `A` | in | 3×3 `data_t` matrix |
| `B` | in | 3×3 `data_t` matrix |
| `C` | out | 3×3 `acc_t` matrix |
| `return` | ctrl | `ap_start` / `ap_done` / `ap_idle` |

AXI-Lite is used because the matrices are small (9 elements each). For larger N, switch A/B/C to `m_axi` (DDR access) or AXI4-Stream.

---

## Repository structure

```
├── src/
│   ├── gemm.h            # N, data_t, acc_t, top-level prototype
│   └── gemm.cpp          # PE, feeders, sinks, collector, top level
├── tb/
│   └── [testbench file]  # C-sim / co-sim testbench
├── hw/
│   ├── [name].bit        # bitstream
│   └── [name].hwh        # hardware handoff (same base name as .bit)
├── notebooks/
│   └── [notebook].ipynb  # PYNQ bring-up and NumPy comparison
└── docs/                 # screenshots: HLS report, block design, results
```

---

## Build flow

1. **Vitis HLS:** C simulation → C synthesis → C/RTL co-simulation → Export RTL (IP), top function `systolic_gemm`, part `xc7z020clg400-1`.
2. **Vivado:** Block design with Zynq-7000 PS (PYNQ-Z2 preset, Block Automation) + the exported IP on `M_AXI_GP0` → generate bitstream.
3. **Files to board:** copy the `.bit` and `.hwh` with the **same base name** into one folder on the PYNQ-Z2.

## Running on PYNQ-Z2

1. Load the overlay with `pynq.Overlay("<name>.bit")`.
2. Inspect `ol.ip_dict` and the IP's `register_map` to find the A, B, C and control registers.
3. Write A and B as raw 16-bit values (real value × 2¹⁰ for `ap_fixed<16,6>`).
4. Set `ap_start`, wait for `ap_done`.
5. Read C as raw 32-bit values and divide by 2¹⁸ (for `ap_fixed<32,14>`).
6. Compare with `numpy.matmul(A, B)`.

---

## Results

| Metric | Value |
|---|---|
| Clock | 174 MHz |
| Latency | 7 cycles |
| DSP48E1 |   220 |
| LUT |   53,200 |
| FF |   106,400 |
| BRAM |  140 |

## Limitations and next steps

- Fixed 3×3; larger matrices need tiling or a larger N within the 220-DSP budget.
- AXI-Lite I/O limits bandwidth; move to `m_axi` or AXI4-Stream for larger data.
- Unskewed feeding; a skewed (wavefront) feed would let PEs start as soon as their operands arrive.
- Accumulator overflow mode is the default (wrap); safe for N = 3 by range analysis, but add `AP_SAT` if N or input range grows.

## Tools

Vitis HLS · Vivado · PYNQ · Python / NumPy · PYNQ-Z2 (Zynq-7020)
