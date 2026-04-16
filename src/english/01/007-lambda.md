## 11. Lambda

`lambda` is a foundation that constructs a single-clause `gamma` with all-bind patterns. Semantically equivalent to `gamma`: `(lambda (a b) body)` = `(gamma ((,a ,b) body))`. The compiler may exploit this equivalence.

**Equivalence:**

```scheme
;; (lambda (a b c) body) is equivalent to:
;; (gamma ((,a ,b ,c) body))
```

Lambda parameters are always bare names (no comma) — all parameters are binds by definition.

**Round:**
```scheme
(define add (lambda (a b) (+ a b)))
```

**Curly:**
```javascript
define add lambda (a b) { (a + b) };
```

**Spacy:**
```python
define add: lambda (a b): (a + b)
```

Lambda must always be explicit. There is no `(define (f x) body)` shorthand. If you want a combiner, you write `gamma` or `lambda`.

