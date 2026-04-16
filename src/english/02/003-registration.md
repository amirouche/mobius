## 23. Registration

Registration converts surface syntax into content-addressed form:

1. **Parse** surface syntax into an AST with names.
2. **Resolve** each name against the current name index, obtaining a hash.
3. **Replace** names with hashes, producing a tree of atoms, pairs, and hash references.
4. **Compute** the hash of the resulting tree.
5. **Store** the tree in the content store (if not already present).
6. **Store** the mapping (name→index associations and language) alongside the combiner.

After registration, the original names are gone from the content. Only hashes remain. The mapping preserves the names as a separate, independently content-addressed artifact.

The dependency graph between top-level definitions is strictly a directed acyclic graph. Definition A may reference definition B only if B is already registered. Top-level mutually recursive definitions are not yet supported (Chapter 33).

Note: the reader and the registration pipeline may internally represent names as symbols. Symbols are an implementation detail of the toolchain, not a user-visible value type. The constraint "no symbols as values" applies to the content store and to runtime, not to intermediate representations.

