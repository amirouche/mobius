## 32. Atlas Stoa

*Atlas Stoa is the read-only aggregation layer above the content store. It is not yet implemented. This chapter records the design direction.*

Atlas Stoa ingests multiple Möbius stores and provides queryable indices across them. It does not modify any store — it is a view, not an authority.

### 32.1 Three embedding axes

Atlas Stoa indexes combiners across three axes:

**Structure.** The de Bruijn tree shape. Structural similarity detection via SimHash or locality-sensitive hashing. Two combiners that solve the same problem differently may have similar structure.

**Behavior.** Which check suites a combiner satisfies. Behavioral indexing groups combiners by what they do, not how they do it. This axis is enriched by ZKP proofs — sealed combiners with proofs participate in behavioral indexing without disclosure.

**Language.** The human-language mappings. A combiner with mappings in Tamazight, French, and English is discoverable from any of those languages.

### 32.2 Near-duplicate detection

`bb search --near` queries the structural axis. Two combiners with high SimHash similarity and no `derived-from` edge between them are flagged — not as accusation, but as a prompt: "did you mean to derive from this?"

### 32.3 Implementation direction

LOUDS-encoded tries for prefix search over hashes. SSTables for sorted key-value storage of index data. ANN (approximate nearest neighbor) indexing for the structural and behavioral axes.

Atlas Stoa operates on disclosed content only. Sealed hashes without ZKP proofs are invisible to all three axes. Sealed hashes with ZKP proofs participate in the behavioral axis only.

