## 31. Oblivious Execution

Oblivious execution — running a computation so that the server performing it cannot observe the code, the inputs, or the intermediate states — is **orthogonal** to Möbius. Möbius is a repository: storage, naming, lineage, verification. Oblivious execution is about runtime privacy. A valid Möbius store requires no oblivious execution support. Oblivious execution requires no content-addressed store.

They are documented together because they create a chain that neither provides alone.

### 31.1 The chain

1. **The Coordinator** writes check suites that define what "correct" means for a problem. The checks are content-addressed and public.

2. **The Privateer** commits a combiner that passes those checks. The content is sealed — only the hash and the OpenTimestamps proof are public. Via a Zero-Knowledge Proof (Chapter 28), the Privateer publishes a cryptographic attestation that the sealed content passes the check suite, without revealing the content.

3. **The Citizen** needs to use the Privateer's capability on private data — tax calculation, medical scoring, vote verification. The Citizen can verify the ZKP proof: the sealed combiner does what the checks require. But the Citizen cannot see the code, and the Privateer must not see the data.

4. **Oblivious execution** resolves this. Using techniques such as Oblivious RAM (ORAM), Trusted Execution Environments (TEEs), or Multi-Party Computation (MPC), the sealed combiner runs on the Citizen's private data in a context where the executing machine sees neither the code logic nor the input data. The result is delivered to the Citizen.

5. **The Reviewer** can audit the ZKP proof independently. The lineage is timestamped. The check suite is public. The proof is content-addressed in `proofs/`. Every step is verifiable without requiring disclosure of the sealed content.

### 31.2 What Möbius provides

Möbius does not implement oblivious execution. It provides the infrastructure that makes oblivious execution *trustworthy*:

- **Content-addressed check suites.** The checks the ZKP attests to are immutable and retrievable by hash. They cannot be swapped after the proof is published.
- **Timestamped lineage.** The Privateer's sealed claim has a verifiable date. The ZKP proof has a verifiable date. The order of events is established cryptographically, not by assertion.
- **Proof as first-class artifact.** The ZKP proof lives in `proofs/` with its own hash, its own timestamp, its own lineage. It can be reviewed, forked, and curated like any other artifact in the store.
- **Behavioral convergence detection.** Sealed hashes with ZKP proofs participate in behavioral indexing — the Curator can discover that multiple sealed combiners satisfy the same check suite, revealing convergence without disclosure. Structural similarity detection (`bb search --near`) requires the de Bruijn tree and cannot operate on sealed content.

### 31.3 What Möbius does not provide

- Runtime isolation. The `bb` toolchain does not sandbox execution.
- Oblivious memory access patterns. These require hardware support (TEEs) or cryptographic protocols (ORAM, MPC).
- A specific ZKP proof system. The choice of proof system (zk-SNARKs, zk-STARKs, Bulletproofs) is an implementation decision, not a language decision.

### 31.4 Why it matters

The Privateer + ZKP + Citizen + Oblivious Execution chain is the strongest argument for Möbius as infrastructure rather than a language. It demonstrates that the content model — immutable trees, content-addressed checks, timestamped lineage, separation of content from naming — serves use cases far beyond programming. The same architecture that lets a Kid in Tizi Ouzou name a function in Tamazight also lets a Citizen verify a sealed algorithm without seeing its source. The infrastructure is the same. The personas are different. The hash doesn't care.


