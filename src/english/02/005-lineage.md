## 25. Lineage

Lineage records the history of a combiner: who created it, when, what it derived from, and what checks it satisfies. Lineage is stored in the `lineage/` subdirectory of each combiner's directory.

### 25.1 Lineage records

A lineage record is a content-addressed file containing:

```scheme
((author . "name")
 (committed . "2026-04-01T14:30:00Z")
 (relation . "add")
 (derived-from . "a4f7e2...")    ;; optional — hash of parent combiner
 (checks . ("c8a31f..." "7b2e04..."))  ;; optional — check hashes
 (note . "...")                  ;; optional — human-readable note
 (replaces . "..."))             ;; optional — hash this supersedes
```

### 25.2 WIP and committed

A lineage record begins as **WIP** (work in progress) when created by `bb add`. It becomes **committed** when promoted by `bb commit`. The distinction is a lifecycle marker:

- WIP lineage has a `created` timestamp.
- Committed lineage has a `committed` timestamp and is eligible for `bb anchor`.

### 25.3 Relations

The `relation` field describes how the combiner came into being:

| Relation | Meaning |
|----------|---------|
| `add` | New content, no derivation |
| `fork` | New line of work derived from existing |
| `fix` | Bug fix |
| `refine` | Improvement without changing behavior |
| `translate` | Same algorithm, different human language mapping |
| `extend` | Added functionality |
| `rewrite` | Complete reimplementation |
| `refactor` | Propagation of a dependency change |
| `commit` | Promotion from WIP to committed |

### 25.4 The lineage graph

The `derived-from` pointers form a directed acyclic graph of derivation. This graph is the structural record of how knowledge evolved. Every edge is timestamped and authored. The graph is append-only — edges cannot be removed once committed.

The lineage graph is distinct from the dependency DAG (which records which combiners reference which other combiners in their de Bruijn trees). Lineage records *how things came to be*. Dependencies record *what things use*.


---

