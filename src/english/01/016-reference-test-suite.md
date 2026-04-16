## 20. Reference Test Suite

The reference test suite is a set of transcript files — Möbius source paired with expected output. A conforming implementation passes all tests.

The test suite is normative: where the prose specification and the test suite disagree, the test suite defines the intended behavior (and the prose should be corrected).

### 20.1 Test categories

| File | What it tests |
|------|---------------|
| `basics.md` | Arithmetic, booleans, conditionals, string literals, cons/car/cdr, equality |
| `recursion.md` | Self-recursion via gamma, mutual recursion, catamorphic sum/product/length, GCD |
| `advanced.md` | Boxes, capsules, call/cc, lambda, higher-order functions |
| `catamorphic-arith.md` | Tree-walking arithmetic evaluator using catamorphic `,(a)` patterns |
| `closures.md` | Closures, currying, composition, accumulators, fold-right |
| `patterns.md` | Multi-argument gamma, nested destructuring, predicate guards, wildcards |

### 20.2 Test format

Each test is a fenced code block followed by expected exit code and expected output:

````markdown
## Test name

```scheme
(display (+ 3 7))
```

Expected exit code: 0
Expected output: 10
````

### 20.3 Transcript tests for the toolchain

Toolchain behavior is tested via bash transcript files that exercise `bb` commands end-to-end:

| File | What it tests |
|------|---------------|
| `00-beyond-babel.md` | `bb store init`, `bb add`, `bb edit` roundtrip |
| `01-triple-evolution.md` | Iterative refinement with `--derived-from`, `bb show`, `bb status` |

These tests are content-addressed once they live in the store. A conforming `bb` implementation passes them.


---

# Part III — The Store

---

