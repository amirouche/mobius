## 9. Evaluation

### 6.1 Application rule

An application expression is evaluated as follows:

1. Evaluate the combiner (the head).
2. Evaluate each argument left to right.
3. Construct the argument tree: `(cons v₁ (cons v₂ (... (cons vₙ #nil))))`.
4. Apply the combiner to that tree.

**Round:** `(f 3 4)` — evaluate `f`, evaluate `3`, evaluate `4`, construct `(3 . (4 . #nil))`, apply.

**Curly:** `f(3 4);` — same evaluation, different syntax.

**Spacy:** `f(3 4)` — same evaluation, different syntax.

A combiner that takes "two arguments" is a combiner whose gamma pattern destructures a two-element tree:

```scheme
;; round
(define add (gamma ((,a ,b) (+ a b))))
(add 3 4)
;; argument tree is (3 . (4 . #nil)), pattern (,a ,b) matches
;; => 7
```

### 6.2 Tree in, tree out

Every combiner takes one argument (a tree) and returns one value (a tree). There is no `values` form and no `call-with-values`. If a procedure wants to return multiple things, it returns a tree containing them. The caller destructures the result with gamma.

```scheme
;; round
(define f (gamma ((,x ,y) (cons (+ x y) (* x y)))))
(define g (gamma ((,sum . ,product) (list sum product))))
(g (f 3 4))
;; => (7 12)
```

### 6.3 Short-circuit forms

`if`, `and`, and `or` are the conditional foundations. All three have non-standard evaluation — they do not evaluate all their arguments.

**`if`** evaluates `test`; if the result is `#false`, evaluates `else`; for any other value, evaluates `then`.

```scheme
;; round
(if test then else)
```

```javascript
// curly
if (test) { then } else { else };
```

```python
# spacy
if (test):
    then
else:
    else
```

Only `#false` triggers the else branch. `0`, `#nil`, `""`, and `#void` are all true.

**`and`** — short-circuit conjunction. Semantically equivalent to nested `if`:

```scheme
(and a b c)
;; equivalent to:
(if a (if b c #false) #false)
```

Returns `#false` as soon as any argument is `#false`; otherwise returns the last value.

**`or`** — short-circuit disjunction. Semantically equivalent to nested `if` with temporary bindings to avoid double evaluation:

```scheme
(or a b c)
```

Returns the first value that is not `#false`. If all are `#false`, returns `#false`.

### 6.4 Infix evaluation (curly and spacy)

In curly and spacy, infix expressions are fully parenthesized:

```javascript
// curly/spacy
(1 + 2)         // valid — reader produces (+ 1 2)
(1 + (2 * 3))   // valid — reader produces (+ 1 (* 2 3))
1 + 2            // READER ERROR — missing parentheses
1 + 2 * 3        // READER ERROR — no precedence
```

There is no operator precedence. Every infix expression must be explicitly parenthesized. The reader translates `(a op b)` to `(op a b)`, producing the same tree as round's prefix form.

An identifier like `+` in argument position (not infix) is just a combiner value:

```javascript
// curly
map(+ my-list);   // passes the combiner + as first arg to map
```

