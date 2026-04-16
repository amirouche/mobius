## 13. Boxes

A box is a mutable indirection cell. Boxes are the only mutable values in Möbius.

### 10.1 Foundations

- `(box v)` — create a new box containing the value `v`.
- `(unbox b)` — return the current contents of box `b`.
- `(box! b v)` — replace the contents of box `b` with `v`. Returns `#void`.

### 10.2 Restrictions

Boxes are **forbidden in top-level definitions**. A top-level `define` must bind an immutable, content-addressable value. Boxes exist only at runtime, within nested scope:

**Round:**
```scheme
(define make-counter
  (lambda ()
    (begin
      (define state (box 0))
      (gamma (("get"  (unbox state))
              ("inc"  (begin (box! state (+ (unbox state) 1))
                             (unbox state))))))))
```

**Curly:**
```javascript
define make-counter lambda () {
    define state box(0);
    gamma {
        case "get": unbox(state);
        case "inc": {
            box!(state (unbox(state) + 1));
            unbox(state)
        };
    }
};
```

**Spacy:**
```python
define make-counter: lambda ():
    define state: box(0)
    gamma:
        case "get": unbox(state)
        case "inc":
            box!(state (unbox(state) + 1))
            unbox(state)
```

### 10.3 Box identity

Each `box` call creates a fresh, distinct cell. `(eq? (box 0) (box 0))` is `#false`.

`equal?` on boxes compares their current contents recursively — it is a snapshot comparison.

### 10.4 Self-referential boxes

A box may contain itself:

```scheme
(define b (box #nil))
(box! b b)
(eq? (unbox b) b)   ;; => #true
```

This is permitted. `equal?` on cyclic box structures is undefined behavior — implementations may diverge, detect the cycle, or signal an error.

