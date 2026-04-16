## 21. Content Model

Möbius separates **content** (immutable, content-addressed) from **naming** (mutable, versioned).

### 21.1 The content store

The content store is an immutable mapping from hashes to trees.

```
store : Hash → Tree
```

Every distinct tree has a unique hash, computed from its structure — atoms, pairs, and references to other hashes. Once stored, a tree cannot be changed. Its hash is its identity.

