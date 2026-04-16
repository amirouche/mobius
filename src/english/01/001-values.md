## 5. Values

All values in Möbius are trees. There are eight categories:

**Atoms.** An integer, a float, a character, or a string.

**Pairs.** Two trees joined by `cons`. The only compositional data constructor. All structures — lists, records, tables, matrices — are built from pairs.

**The empty list.** Written `#nil` in all surfaces. `(eq? #nil #nil)` is `#true`.

**Booleans.** `#true` and `#false`. Only `#false` is false — it is the sole value that causes `if` to take the else branch. Every other value, including `0`, `#nil`, and the empty string, is considered true.

**The void value.** `#void` is a pre-defined singleton. It is the conventional return value of side-effecting operations like `box!` and `display`. `#void` is true (it is not `#false`).

**Capsules.** An opaque value tagged with an integer smaller than 2¹²⁸ serving as a type identifier (Chapter 12). Two trees with identical structure but wrapped in different capsule types are distinct.

**Combiners.** The result of evaluating a `gamma` or `lambda` expression. A combiner is a tree that, when applied, receives a tree and produces a tree.

**Boxes.** A mutable indirection cell created by `box`, read by `unbox`, mutated by `box!` (Chapter 13). Boxes are the only mutable values in Möbius. They are forbidden in top-level content-addressed definitions.

**Continuations.** A first-class value representing a point of execution, created by `call/cc` (Chapter 15). Continuations are runtime-only — they cannot be stored in the content store. They are not combiners: you cannot apply them with the application rule. Use `continuation-apply` to deliver a value to a continuation.

There is no distinction between "data" and "code" at the structural level. Both are trees.

There are no symbols as values. Names in source syntax are resolved to content hashes at registration time.

There is no `quote` and no `quasiquote`. All data construction is explicit, through `cons` and the `list` library function. This eliminates the question of what symbols become when quoted — they don't exist as values, and there is no mechanism that pretends otherwise.

