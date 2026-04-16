## 8. Patterns

Patterns describe the shape of a tree and how to bind parts of it. Pattern syntax is **identical across all three surfaces**.

### 5.1 Pattern forms

**Literal.** `42`, `"hello"`, `#true`, `#false`, `#nil` — matches that exact value.

**Bind.** `,x` — matches any value and binds it to `x`.

**Recurse-and-bind.** `,(x)` — matches any value, applies the enclosing gamma combiner to it recursively, and binds the result to `x`.

**Wildcard.** `,_` — matches any value, binds nothing.

**Pair pattern.** `(p₁ . p₂)` — matches a pair whose car matches `p₁` and cdr matches `p₂`.

**List pattern.** `(p₁ p₂ p₃)` — shorthand for nested pair patterns ending in `#nil`. `(,a ,b ,c)` expands to `(,a . (,b . (,c . #nil)))`.

**Predicate guard.** `(? pred ,x)` — applies `pred` to the value; if it returns a true value (anything other than `#false`), binds the value to `x`; if `#false`, the clause fails. The comma on the binding variable is mandatory.

### 5.2 No bare identifiers

Bare identifiers in patterns are forbidden. The toolchain rejects any bare identifier in pattern position as an error.

```scheme
;; WRONG — registration error
(gamma ((a b) 42))

;; CORRECT — bind two values
(gamma ((,a ,b) 42))

;; CORRECT — gamma literal values
(gamma ((0 1) 42))
```

This eliminates ambiguity between "match a resolved value" and "bind a new variable." There is no confusion.

### 5.3 The comma

The comma is the central syntactic device in Möbius patterns. It always means: computation has occurred before binding.

- `,x` — bind (extract the subtree).
- `,(x)` — recurse then bind (the enclosing gamma is applied to the subtree before binding).

Outside of patterns, comma has no syntactic role — it is **not** an argument separator in any surface.

### 5.4 Tail matching

Tail matching uses dot notation:

```scheme
;; round
(gamma ((,a ,b . ,rest) (list a b rest)))
```

```javascript
// curly
gamma { case (,a ,b . ,rest): list(a b rest) }
```

```python
# spacy
gamma:
    case (,a ,b . ,rest): list(a b rest)
```

