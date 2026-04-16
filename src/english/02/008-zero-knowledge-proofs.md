## 28. Zero-Knowledge Proofs

A sealed hash proves existence and priority. It does not prove capability. Zero-Knowledge Proofs close that gap without breaking the seal.

A ZKP allows the holder of sealed content to publish a cryptographic proof that their hidden combiner passes a given check suite — the same `bb check` infrastructure every other participant uses — without revealing the content itself. The proof binds a specific sealed hash to a specific content-addressed check suite: "the combiner at hash H satisfies checks C." The silent hash becomes a **verified capability**.

**Proof placement.** Proofs are content-addressed artifacts stored in `proofs/`, adjacent to the combiner they attest to, with their own timestamps. They are not fields in the mapping or the lineage record. This keeps naming clean and makes proofs first-class objects that the Curator can query across the store.

**Two zones of sealed content.** Not all sealed hashes are equal. The store distinguishes:

*Sealed without ZKP.* A hash and a timestamp. No behavioral properties are visible. Structural similarity detection (`bb search --near`) cannot operate — it requires the de Bruijn tree, which is not public. If it were, the seal would be broken. The Curator is blind. This is the honest cost of accommodating sealed content.

*Sealed with ZKP.* The content is hidden but the capabilities are visible — specifically, which check suites are satisfied. If three sealed hashes each have ZKP proofs against the same check suite, the Curator sees behavioral convergence: three implementations satisfying the same specification, identifiable by what they satisfy rather than what they contain. The check suite is the shared vocabulary that lets sealed work participate in the graph without disclosure.

**What does not change.** The content store, the de Bruijn normalization, the hashing, the naming layer — none of these are affected by ZKPs. The proof is an overlay, not a modification. A store without any ZKP infrastructure is a valid Möbius store. ZKPs are a companion technology that strengthens the Privateer's participation without requiring every implementation to support them.

# Part IV — The Toolchain

---

