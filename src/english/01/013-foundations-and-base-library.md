## 17. Foundations and Base Library

The vocabulary of Möbius is organized by a single criterion: **can it be written in Möbius?**

**Foundations** are forms and combiners that require the evaluator or runtime. They cannot be expressed as Möbius programs. Some foundations have equivalent expansions in terms of other foundations — `lambda` in terms of `gamma`, `and` in terms of `if`. These equivalences are semantic facts the compiler may exploit, not a hierarchy of dependence. The language *chooses* to present all of them as building blocks.

**Base library** combiners are Möbius programs. They have content hashes and live in the store. They are the first programs written in the language, shipped alongside it. Any programmer could write them.

### 14.1 Foundations

**Core forms** (special evaluation rules):

| Foundation | Role |
|---|---|
| `gamma` | Tree destructuring, binding, catamorphism, combiner construction |
| `if` | Conditional — only `#false` triggers the else branch |
| `and` | Short-circuit conjunction. Equivalent to nested `if`: `(and a b c)` = `(if a (if b c #false) #false)` |
| `or` | Short-circuit disjunction. Returns first non-`#false` value. Equivalent to nested `if` with temporary bindings. |
| `lambda` | Single-clause `gamma` with all-bind patterns. `(lambda (a b) body)` = `(gamma ((,a ,b) body))` |
| `begin` | Sequencing (round surface; braces in curly, indentation in spacy) |
| `define` | Bind a name (top-level: content hash; nested: local binding) |
| `guard` | Install entry/exit gamma clauses on a continuation boundary |

**Data construction and access:**

| Foundation | Role |
|---|---|
| `cons` | Construct a pair |
| `car` | First element of a pair |
| `cdr` | Second element of a pair |
| `encapsulation-type` | Create a capsule type from an integer < 2¹²⁸ (constructor, predicate, accessor) |
| `box` | Create a mutable box |
| `unbox` | Read box contents |
| `box!` | Mutate box contents |
| `list->string` | Convert a list of characters to a string |
| `string->list` | Convert a string to a list of characters |
| `integer->char` | Convert an integer (Unicode code point) to a character |
| `char->integer` | Convert a character to its integer code point |

**Continuations:**

| Foundation | Role |
|---|---|
| `call/cc` | Reify the current continuation |
| `continuation-apply` | Deliver a value to a captured continuation |

**Type predicates:**

| Foundation | Role |
|---|---|
| `integer?` | Test if value is an integer |
| `float?` | Test if value is a float |
| `char?` | Test if value is a character |
| `string?` | Test if value is a string |
| `pair?` | Test if value is a pair |
| `box?` | Test if value is a box |
| `combiner?` | Test if value is a combiner |
| `continuation?` | Test if value is a continuation |

**Comparison and arithmetic:**

| Foundation | Role |
|---|---|
| `eq?` | Identity comparison |
| `+`, `-`, `*`, `/` | Arithmetic |
| `<`, `>`, `=` | Comparison |

**I/O and assertions:**

| Foundation | Role |
|---|---|
| `display` | Write a value to standard output. Returns `#void`. |
| `assume` | Runtime assertion. If the first argument is `#false`, signal failure with the optional second argument as message. If true, returns `#true`. The failure mechanism is host-specific; the semantics — "if false, stop" — are portable. |

**Well-known bindings** (values bound in the initial environment):

| Binding | Role |
|---|---|
| `continuation-exit` | The root continuation — delivers an exit code 0–255 to terminate |
| `#true`, `#false`, `#nil`, `#void`, `#eof` | Pre-defined constants |

**Foundation count:** 8 core forms + 11 data + 2 continuations + 8 type predicates + 8 arithmetic/comparison + 2 I/O/assertions = **39 foundations**.

### 14.2 Base library

Möbius programs shipped with the system. They have content hashes and live in the content store.

| Name | Definition | Role |
|---|---|---|
| `list` | `(gamma (,args args))` | Identity — returns the argument tree. `(list 1 2 3)` constructs `(1 . (2 . (3 . #nil)))` via the application rule and returns it unchanged. |
| `not` | `(gamma ((#false #true) (,_ #false)))` | Boolean negation |
| `equal?` | Recursive structural comparison using `gamma`, `pair?`, `eq?`, `car`, `cdr`, `unbox`, `box?`. Pairs compared element-wise. Capsules opaque (only `eq?`). Boxes compared by current contents. | Deep equality |
| `continuation-extend` | Built from `call/cc` and `continuation-apply`. Takes a continuation and a combiner, returns a new continuation such that delivering `v` applies `f` to `v` first, then delivers the result to `k`. | Continuation composition |
| `capsule-constructor` | `(gamma ((,type) (car type)))` | Extract the constructor from an `encapsulation-type` result. |
| `capsule-predicate` | `(gamma ((,type) (car (cdr type))))` | Extract the predicate from an `encapsulation-type` result. |
| `capsule-unwrap` | `(gamma ((,type) (car (cdr (cdr type)))))` | Extract the accessor from an `encapsulation-type` result. |
| `error` | Takes an exit code, a message string, and a tree. Displays the message and tree via `display`, then delivers the exit code to `continuation-exit`. | Error reporting and termination |

Note on `eq?` vs `equal?`: `eq?` tests identity — whether two values are the same object. For atoms, `eq?` compares values. For pairs, `eq?` compares identity. For capsules, `eq?` compares identity. For boxes, `eq?` compares cell identity. `equal?` recurses through pairs and box contents. Capsules are opaque to `equal?` — two capsules are `equal?` only if they are `eq?`.

