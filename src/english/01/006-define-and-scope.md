## 10. Define and Scope

### 7.1 Top-level define

`define` binds a name to a value.

**Round:** `(define name expression)`

**Curly:** `define name expression;`

**Spacy:** `define name: expression`

Top-level definitions are immutable and content-addressed. The expression may be a combiner (`gamma` or `lambda`), a constant (atom, pair, list), or any expression that evaluates to an immutable value. Boxes are forbidden in top-level definitions.

### 7.2 Content addressing

In the content-addressed representation, a defined combiner has no free variables. Every reference to another definition is resolved to a content hash.

```scheme
;; round
(define x 10)
(define f (gamma ((,a) (+ a x))))
```

In the stored form, `f` does not contain a free reference to `x`. It contains the hash of `10`.

### 7.3 The dependency DAG

The dependency graph between top-level definitions is strictly a directed acyclic graph. Definition A may reference definition B only if B is already registered.

Top-level mutually recursive definitions are not yet supported. The design of definition bundling is an open question (Chapter 33). Mutually recursive functions can be defined as local bindings within a single top-level combiner using nested `define` (§10.4).

### 7.4 Nested define

Within a combiner body, `define` creates local bindings. Nested definitions are mutually visible (hoisted), enabling local mutual recursion.

### 7.5 No let, no let\*

Möbius has no `let`, `let*`, or `letrec` as separate binding forms. All local binding is done through nested `define` within a `begin` block (round), brace block (curly), or indented block (spacy). Since nested defines are mutually visible, this subsumes `letrec`.

### 7.6 Sequencing

**Round:** `(begin e₁ e₂ ... eₙ)` — evaluates each expression in order, returns the value of `eₙ`.

**Curly:** `{ e₁; e₂; ... eₙ }` — braces and semicolons. Last expression is the return value.

**Spacy:** Newlines under the same indentation level. Last expression is the return value.

`begin` is a universal concept — only its surface syntax varies.

