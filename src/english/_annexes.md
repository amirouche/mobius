# Annexes

---

## Annex A. Ellipsis (Possible Future Addition)

The ellipsis `...` in a pattern would mean "zero or more repetitions of the preceding sub-pattern." Each `...` would add one depth level to the bindings it contains. In the body, `...` would expand those bindings at the corresponding depth. This section sketches the design; it is not part of the current language.

### A.1 Basic iteration — depth 1

```scheme
;; collect all elements
((gamma ((,a ...) (,a ...)))
 (list 1 2 3))
;; => (1 2 3)

;; transform each element
((gamma ((,a ...) ((* 2 a) ...)))
 (list 1 2 3))
;; => (2 4 6)
```

`a` is bound at depth 1. In the body, `(* 2 a) ...` iterates over `a`.

### A.2 Parallel bindings

```scheme
((gamma (((,a ,b) ...) ((+ a b) ...)))
 (list (list 1 10) (list 2 20) (list 3 30)))
;; => (11 22 33)
```

Mismatched lengths are an error.

### A.3 Nested ellipsis — depth 2

```scheme
;; flatten a list of lists
((gamma (((,a ...) ...) (,a ... ...)))
 (list (list 1 2) (list 3 4) (list 5 6)))
;; => (1 2 3 4 5 6)

;; double every element, preserving structure
((gamma (((,a ...) ...) (((* 2 a) ...) ...)))
 (list (list 1 2) (list 3 4)))
;; => ((2 4) (6 8))

;; double every element, then flatten
((gamma (((,a ...) ...) ((* 2 a) ... ...)))
 (list (list 1 2) (list 3 4)))
;; => (2 4 6 8)
```

### A.4 Depth rules

- Each `...` in a pattern adds one depth level.
- In the body, each `...` consumes one depth level.
- A depth-0 binding under `...` is repeated at each iteration.
- Multiple bindings at the same depth must have the same length.
- Depth mismatch is an error.

**Restrictions:** `...` only at the tail of a list pattern. `(,a ... ,b)` is not allowed. `(,a ... . ,rest)` is not supported.

**Interaction with catamorphism:** Ellipsis and `,(x)` are orthogonal. They can appear in the same gamma.

## Annex B. Predicate-Driven Optimization

Predicate information drives compiler optimization:

**Representation narrowing.** A value satisfying `uint4?` needs only 4 bits.

**Pointer tagging.** Known predicate constraints free up tag bits.

**Dead code elimination.** Gamma clauses ruled out by predicates are unreachable.

**Check elimination.** Runtime checks implied by known predicates are redundant.

**Specialization.** Known predicates enable specialized code paths.

## Annex C. Representation Inference

The only compositional data constructor is `cons`. The compiler infers optimal machine representations from predicate knowledge:

**Byte vectors.** A list of `uint8?` values with known length → contiguous bytes.

**Arrays.** Homogeneous known-length list → flat array with O(1) indexed access.

**Structs.** Fixed-position pair structure with known types → struct with fixed offsets.

**Hash tables.** Association list consistently accessed by key → amortized O(1) lookup.

Capsules are the natural boundary where representation choices stabilize. The capsule's opacity guarantees no external code depends on internal layout, freeing the compiler to change representations without breakage.

## Annex D. Knowledge Economy

*Reference: Aaron Hsu, "Programming Obesity: A Code Health Epidemic" (FnConf 2019)*

Hsu proposes three axes for evaluating programming systems: simplicity (structural complexity), speed (execution performance), and economy (how much knowledge scales to a broad set of problems).

Economy is measured as the ratio of domain-specific names to total names in a program. Fewer unique concepts → less code → faster execution → more knowledge reuse. These compound rather than trade off.

Möbius is designed for high economy: one data type (tree), one mechanism (`gamma`), ~39 foundations. No frameworks, no DSLs, no separate type language. The programmer's attention is spent on the domain problem, not on systems rumination.

## Annex E. Abacus — An Arithmetic Evaluator

This annex demonstrates catamorphic match on a concrete problem: evaluating arithmetic expression trees. The entire evaluator is one `gamma` with no explicit recursion.

### E.1 Representation

Expression trees use string tags as node labels:

```scheme
;; round
(list "add" 1 (list "mul" 2 3))          ;; 1 + (2 * 3) = 7
(list "sub" (list "add" 10 5) 3)         ;; (10 + 5) - 3 = 12
(list "mul" (list "add" 1 2) (list "add" 3 4)) ;; (1 + 2) * (3 + 4) = 21
```

A number is a leaf. A tagged list `("op" left right)` is a branch. This is a tree — `cons` all the way down.

### E.2 The evaluator

**Round:**
```scheme
(define abacus
  (gamma ((? integer? ,n) n)
         (("add" ,(left) ,(right)) (+ left right))
         (("sub" ,(left) ,(right)) (- left right))
         (("mul" ,(left) ,(right)) (* left right))
         (("div" ,(left) ,(right)) (/ left right))))

(abacus (list "add" 1 (list "mul" 2 3)))
;; => 7

(abacus (list "mul" (list "add" 1 2) (list "add" 3 4)))
;; => 21
```

**Curly:**
```javascript
define abacus gamma {
    case (? integer? ,n): n;
    case ("add" ,(left) ,(right)): (left + right);
    case ("sub" ,(left) ,(right)): (left - right);
    case ("mul" ,(left) ,(right)): (left * right);
    case ("div" ,(left) ,(right)): (left / right);
};

abacus(list("add" 1 list("mul" 2 3)));
// => 7
```

**Spacy:**
```python
define abacus: gamma:
    case (? integer? ,n): n
    case ("add" ,(left) ,(right)): (left + right)
    case ("sub" ,(left) ,(right)): (left - right)
    case ("mul" ,(left) ,(right)): (left * right)
    case ("div" ,(left) ,(right)): (left / right)

abacus(list("add" 1 list("mul" 2 3)))
# => 7
```

### E.3 How it works

The key is `,(left)` and `,(right)`. These are catamorphic binds — before the body runs, `abacus` is applied recursively to each subtree.

Trace of `(abacus (list "add" 1 (list "mul" 2 3)))`:

1. Input matches `("add" ,(left) ,(right))`.
2. `left`: apply `abacus` to `1`. Matches `(? integer? ,n)`. Returns `1`.
3. `right`: apply `abacus` to `("mul" 2 3)`. Matches `("mul" ,(left) ,(right))`.
   - `left`: apply `abacus` to `2`. Returns `2`.
   - `right`: apply `abacus` to `3`. Returns `3`.
   - Body: `(* 2 3)` → `6`.
4. Body: `(+ 1 6)` → `7`.

The programmer writes no recursive calls. The fold is declared in the pattern. The body only sees already-computed values.

### E.4 Extending the evaluator

Adding negation — a unary operation:

**Round:**
```scheme
(define abacus
  (gamma ((? integer? ,n) n)
         (("add" ,(left) ,(right)) (+ left right))
         (("sub" ,(left) ,(right)) (- left right))
         (("mul" ,(left) ,(right)) (* left right))
         (("div" ,(left) ,(right)) (/ left right))
         (("neg" ,(inner))         (- 0 inner))))

(abacus (list "neg" (list "add" 1 2)))
;; => -3
```

Each new operation is one clause. The catamorphism handles the recursion automatically — `,(inner)` evaluates the subtree before the body sees it.

### E.5 What this demonstrates

- **One mechanism.** `gamma` handles dispatch, destructuring, recursion, and result construction. No visitor pattern, no interpreter loop, no recursive function definition.
- **The pattern is the program.** The shape of the clause *is* the specification of what the evaluator does. Reading the pattern tells you the input structure; reading the body tells you the output.
- **Catamorphism terminates.** Because `,(x)` only recurses into strict sub-parts of the matched value, the evaluator terminates on any finite expression tree. This is a structural guarantee, not a proof obligation.
- **Economy.** The evaluator uses 6 names from Möbius (`gamma`, `integer?`, `+`, `-`, `*`, `/`) and 5 from the domain (`"add"`, `"sub"`, `"mul"`, `"div"`, `"neg"`). Half the program is the problem; half is the tool.


## Annex F. Historical Changelog

### F.1 Changes from Draft 4 to Draft 5 (February 2026)

- **`match` renamed to `gamma`.** The core mechanism is now called `gamma`, reflecting its role as the sole combiner constructor. All sections, examples, and grammar updated.
- **Quote and quasiquote removed.** `quote`, `quasiquote`, `unquote`, `unquote-splicing` eliminated from all surfaces, foundations, and grammar. All data construction through `cons` and the `list` library function.
- **Anonymous combiners forbidden in all surfaces.** Every `gamma` or `lambda` must be named via `define`. This constraint — motivated by spacy's inability to delimit inline anonymous combiners — is now universal to maintain surface equivalence.
- **Two-tier vocabulary: foundations and base library.** The vocabulary is organized by a single criterion: can it be written in Möbius? Foundations (~34) require the evaluator or runtime. Base library combiners are Möbius programs with content hashes. The terms "primitive", "sugar", and "registration-time form" are retired.
- **Foundations are not irreducible.** Some foundations have equivalent expansions in terms of others (`lambda` in terms of `gamma`, `and` in terms of `if`). These are semantic equivalences the compiler may exploit, not a hierarchy.
- **Capsule types use non-generative identifiers.** `encapsulation-type` takes an integer smaller than 2¹²⁸. Same identifier anywhere = same type. Library combiners `capsule-constructor`, `capsule-predicate`, `capsule-unwrap` simplify the common pattern.
- **Type predicates are foundations.** `integer?`, `float?`, `char?`, `string?`, `pair?`, `box?`, `combiner?`, `continuation?` are explicit foundations.
- **`display` is a foundation** (requires OS interaction). `equal?`, `not`, `continuation-extend` are base library.
- **Truthiness clarified.** Only `#false` is false. `0`, `#nil`, `""`, `#void` are all true. `or` returns first non-`#false` value.
- **`#void` and `#eof` are pre-defined singletons.**
- **Hex integer literals.** `0xC0FF33` is valid reader syntax for positive integers.
- **Comment syntax per surface.** Round: `;`. Curly: `//`. Spacy: `#`. All surfaces support `#;` datum comments.
- **Mutual recursion moved to open questions.** Top-level mutually recursive definitions are not yet supported. The design of definition bundling is deferred.
- **`error` added to base library.** Takes exit code, message, and a tree.
- **Interpreter milestones section removed** (implementation details, not specification).

---

*This document records the design of Möbius as understood in April 2026. It is a working manual, not a final standard. The "0" in R⁰RM reflects this: it is the revision before revision, the seed before the tree.*

*Same hash, different names. Same kaleidoscope, different colors. The mobius-store is append-only. The hashes remain. No more ghosts.*
