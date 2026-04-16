## 24. Combiner Structure

A combiner in the content store is a tree containing:

- **Atoms**: integers, floats, characters, strings — self-hashing.
- **Pairs**: structure — hash is computed from the hashes of car and cdr.
- **Hash references**: pointers to other content (foundations, constants, other combiners).
- **Bound variables**: positions introduced by patterns and used within the same combiner.

Bound variables are local to a combiner and represented by position (de Bruijn indices or equivalent), not by name. This ensures that alpha-equivalent combiners hash to the same value.

### 24.1 Foundations in the content store

Foundations are forms and combiners built into the runtime with reserved hashes — integers smaller than 2¹²⁸, known to all implementations. Foundations are not stored in the content store — they are intrinsic.

