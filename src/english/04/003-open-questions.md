## 33. Open Questions

The following are identified for future revisions:

1. **Predicate inference.** The compiler infers predicates from known properties of foundations — `car` requires `pair?`, `+` requires `integer?` or `float?`. Gamma clause structure propagates these predicates. The programmer may add assert hints. The formal specification of the inference mechanism, the set of foundation predicate signatures, and the interaction between capsule-level inference and tree-level predicates remain to be detailed.

2. **Effects.** Effects in Möbius are named patterns over existing continuation foundations, not new foundations. `raise` (one-shot, no resumption), `raise-continuable` (one-shot resumption), and coroutines (multi-shot, sequential resumption) are defined in terms of `guard`, `call/cc`, `continuation-apply`, and `gamma`. The compiler recognizes these named patterns and optimizes accordingly: `raise` compiles to a jump, `raise-continuable` to a call, coroutines to stack switching. The formal definitions remain to be specified.

3. **eval semantics.** Without symbols as values and without quote, `eval` in the traditional Lisp sense is not possible. What remains is hash lookup: given a content hash, retrieve and execute the corresponding combiner from the content store. A possible foundation `integer->combiner` would take a hash (an integer) and return the corresponding combiner. Open questions: Is this a foundation, or is it implicit in application? What happens when a hash is not in the content store? What are the security implications of arbitrary hash execution?

4. **Error model.** What happens when a gamma fails (no clause matches)? When `car` is applied to an atom? When division by zero occurs? The spec needs to define: what an error value is (likely a capsule), how errors are raised (likely via `continuation-apply` to the nearest guard), and how they interact with `guard`. This is critical for implementers.

5. **Naming layer representation.** How are mappings organized and discovered across federated stores? The current implementation scans all mappings on demand to build a name index. For large stores, this may require indexing. How do multiple stores compose their name indices? Store modes: local-only, federated, centralized.

6. **Concurrency.** Möbius's tree-in-tree-out model and immutable content store are natural fits for concurrent and distributed computation. CSP-style channels (read-channel, write-channel, select) are a candidate model. The interaction between concurrency, boxes, and continuations needs careful specification.

7. **Cycle detection for equal? on boxes.** Self-referential boxes are permitted. `equal?` on cyclic box structures is currently undefined behavior. Should implementations be required to detect cycles?

8. **I/O model.** `display` is a foundation but I/O is otherwise unspecified. How do file handles, network sockets, and other resources interact with the content-addressed model? Are they capsules wrapping OS handles?

9. **Top-level mutual recursion.** How should the toolchain handle mutually recursive top-level definitions? It could detect mutual groups and bundle them into a single content-addressed unit whose hash covers the entire group. Open questions: How are stale references handled when one member is updated without the others? Should tooling warn about broken mutual groups? What is the interaction with the dependency DAG?

10. **Capsule type ID derivation.** How should programmers choose type identifiers to avoid collisions? Possible strategies include deriving IDs deterministically from a hash of the defining module's content and a local name. A recommended derivation scheme would reduce accidental collisions.

11. **ZKP proof format and verification.** What proof system is used? How are proofs verified without the content? What is the interaction between the proof and the check suite — does the proof attest to a specific check suite hash, or to a property expressed independently? How does proof size scale with combiner complexity? These are implementation questions, not language questions, but they determine whether §1.7 is practical.

12. **Oblivious execution integration.** Oblivious execution (ORAM, TEEs, MPC) is orthogonal to Möbius — it is a runtime concern, not a storage concern. But the Privateer + Citizen chain (verified capability via ZKP, private data via oblivious execution) is a primary use case for the infrastructure. What interfaces, if any, should the `bb` toolchain provide to support oblivious execution? Is this a `bb run --oblivious` flag, a separate tool, or entirely outside scope? See Chapter 31.

13. **Metaprogramming as tree inspection.** Three questions that appear opposite converge on the same answer: (a) how to do metaprogramming without reintroducing `vau`, (b) how to statically prove program properties with the same language used to program, (c) how to keep the result content-addressable and multilingual. The answer may be: trees all the way down. A stored combiner is already a de Bruijn tree — it is data. A combiner that takes another combiner's tree as input and pattern-matches on its structure is metaprogramming. No `vau` needed because no unevaluated operands are needed — the tree is already in the store, already normalized, already data. The question is whether this is expressive enough to be useful.

14. **Static checks vs dynamic checks.** A check that receives a combiner and calls it is a dynamic assertion (runtime verification). A check that receives a combiner's de Bruijn tree and inspects its structure is a static assertion (registration-time verification). Both are lambdas. Both are content-addressed. Both live in the store. The difference is what they receive — the closure or the tree.

    Static checks can verify structural properties: "does this combiner have a base case for `#nil`?", "does every recursive call go through catamorphic bind?", "does the combiner reference only foundations and declared dependencies?". These are tree-shape predicates — pattern matching on the de Bruijn form.

    Semantic static checks are harder: "does this combiner return a sorted list?" requires reasoning about the meaning of the tree, not just its shape. The boundary between structural checks (tractable), bounded semantic checks (possible for restricted domains like arithmetic and termination), and general semantic checks (undecidable) needs to be mapped. `assume` is the escape hatch: where static verification stops, the programmer asserts and the compiler trusts. This is the same position as Agda's `postulate` — honest about where the proof ends.

    The ZKP story benefits directly: proving a static check over a sealed tree is cheaper than proving an execution trace, because the circuit needs only tree traversal, not the full evaluator. If the boundary between static and dynamic checks is well-drawn, the Privateer can prove structural properties cheaply and reserve execution-trace proofs for behavioral claims.

15. **Parameterization of infrastructure.** Three aspects of the system are currently hardcoded and should become parameters: (a) the anchor target — `bb anchor` currently assumes Bitcoin via OpenTimestamps, but the architecture should accommodate multiple anchor chains; (b) the hashing algorithm — SHA-256 is the current choice, but the hash function should be a parameter so the store can migrate if SHA-256 is weakened; (c) the ZKP proof format — `proofs/` should accept multiple proof systems (zk-SNARKs, zk-STARKs, Bulletproofs) for the same claim. All three follow the same principle: the store records *what was used*, the choice is the user's. Same pattern as `mappings/` being language-agnostic. The design question is how to encode the parameter choice without breaking content-addressability — if two stores use different hash functions, their hashes for the same tree will differ.

-----

*This document records the design of Möbius as understood in April 2026. It is a working specification, not a final standard. The "0" in R0RM reflects this: it is the revision before revision, the seed before the tree.*

-----


---

