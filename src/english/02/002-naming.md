## 22. Naming

Names are views into mappings stored alongside combiners. There is no separate "registry" data structure. The name→hash relationship is emergent: each combiner in the content store may have one or more **mappings** — content-addressed files that associate de Bruijn indices with human-readable names in a specific language.

```
mapping : (Index → Name) × Language × Hash
```

The same combiner hash may have mappings in multiple languages. The same function named differently in different languages points to the same hash:

```
"odd?"  → 0x7a3f...   (English mapping)
"impair?" → 0x7a3f...   (French mapping)
"فردي؟"  → 0x7a3f...   (Arabic mapping)
```

A **name index** is computed on demand by scanning all mappings in the store. It is a derived view, not stored state. The name index maps the name at position 0 of each mapping (the combiner's own name) to its content hash. When multiple combiners share a name, disambiguation uses the short hash suffix.

Naming is the **image** — the living, evolving view into the content store. Adding a new mapping for a combiner does not change the combiner's tree or hash. Mappings are independently content-addressed, timestamped, and authored. A mapping is a real intellectual contribution — naming is meaning.

