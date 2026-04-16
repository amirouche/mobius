## 15. Continuations and Control Flow

Möbius provides three continuation foundations and one well-known continuation binding for non-local control flow. Because content-addressed definitions have no free variables, these foundations operate entirely at runtime on the continuation — the chain of pending computation — rather than on lexical environments.

### 12.1 call/cc

`call/cc` takes a single combiner as argument and calls it with a first-class continuation object representing the current point of execution. This continuation is unlimited — it captures the entire future of the computation. The continuation is a value like any other and may be stored in a tree, returned, or passed to other combiners. It remains valid indefinitely, including after the dynamic extent of the `call/cc` has exited.

If the continuation is never applied, it has no effect. The combiner may return normally, in which case the result of `call/cc` is whatever the combiner returns.

### 12.2 continuation-apply

`continuation-apply` takes a continuation object and a value, and delivers that value to the captured continuation. This abandons the current computation entirely — control jumps to the point captured by `call/cc`, and the delivered value becomes the result of that original `call/cc` expression.

If the continuation crosses guard boundaries, the corresponding guard clauses are invoked during the pass. Applying a continuation that was captured in a dynamic extent that has already exited is permitted. Applying the same continuation multiple times is permitted.

### 12.3 guard

`guard` installs entry and exit gamma clauses on a continuation boundary and executes a thunk within that boundary. It merges the roles of Scheme's `guard` (exception handling) and `dynamic-wind` (entry/exit behavior) into a single pattern-based mechanism.

**Round:**
```scheme
(guard
  (entry (pattern₁ handler₁)
         (pattern₂ handler₂)
         ...)
  thunk
  (exit (pattern₁ handler₁)
        (pattern₂ handler₂)
        ...))
```

**Curly:**
```javascript
guard {
    entry:
        case pattern₁: handler₁;
        case pattern₂: handler₂;
    body: thunk;
    exit:
        case pattern₁: handler₁;
        case pattern₂: handler₂;

};
```

**Spacy:**
```python
guard:
    entry:
        case pattern₁: handler₁
        case pattern₂: handler₂
    body: thunk
    exit:
        case pattern₁: handler₁
        case pattern₂: handler₂

```

**Entry clauses.** When an abnormal pass (a value delivered via `continuation-apply`) crosses into this guard boundary from outside, the passed value is matched against the entry clauses in order. If a clause matches, its body executes to handle the pass. If no clause matches, the pass propagates automatically.

**Thunk.** A zero-argument combiner that executes as the guarded body. The thunk runs within the protection of the guard boundary.

**Exit clauses.** When an abnormal pass crosses out of this guard boundary to outside, the passed value is matched against the exit clauses. This is the cleanup mechanism — exit clauses run when control leaves the guarded region, whether normally or via continuation.

Guards are the sole mechanism for intercepting non-local control flow. They subsume exception handling (entry clauses matching error values), cleanup (exit clauses performing side effects then propagating), and dynamic-wind entry/exit behavior (entry and exit clauses on the same boundary).

The key edge case: if a guard clause itself signals an abnormal exit, that exit propagates outward past the current guard — a guard does not intercept its own errors.

### 12.4 The root continuation (continuation-exit)

`continuation-exit` is a well-known binding — not a separate foundation, but the root continuation that exists when a program starts. It represents "terminate the process."

Delivering a value to `continuation-exit` terminates the program. The delivered value must be an integer 0–255 (POSIX exit code). Delivering a non-integer or out-of-range value is an error.

```scheme
;; round
(continuation-apply continuation-exit 0)   ;; exit successfully
```

```javascript
// curly
continuation-apply(continuation-exit 0);
```

```python
# spacy
continuation-apply(continuation-exit 0)
```

Guards installed between the current point and the root continuation are traversed on exit, so cleanup code runs.

If the program's main expression returns normally (without explicitly calling `continuation-exit`), the runtime delivers `0` to the root continuation — successful termination.

