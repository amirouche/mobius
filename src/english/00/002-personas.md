## 2. Personas

*Same kaleidoscope, different colors. Each persona sees Möbius from a different angle. None of them are wrong. None of them see the whole thing.*

### Quick Map

**Who arrives and why — the 17 personas:**

| # | Persona | What brings them |
|---|---------|-----------------|
| 1 | The Garage Lab Hacker | Priority without permission |
| 2 | The Polyglot Programmer | Names in their language, as originals |
| 3 | The PL Theorist | Economy, catamorphism, the deliberate exclusions |
| 4 | The Burned-Out Senior Dev | What Möbius removes |
| 5 | The Civilizational Thinker | Infrastructure that outlasts its moment |
| 6 | The Kid in Tizi Ouzou | The tool works when they pick it up |
| 7 | The Academic Researcher | Priority before publication, reproducibility is the hash |
| 8 | The Independent Researcher | The hash *is* the institution |
| 9 | The Community Steward | Collective knowledge, non-individual attribution |
| 10 | The Privateer | Priority proof without disclosure |
| 11 | The Person Who Was Stolen From | Grief, then recognition |
| 12 | The Connector | Findability across difference |
| 13 | The Educator | Lessons with traceable lineage |
| 14 | The Artist | Demoscene, music, Blender — derivation as honor |
| 15 | The Citizen | Illegibility of power, made auditable |
| 16 | The Representative | Trust under complexity, decisions with traceable provenance |
| 17 | The Symbiotic Artificial Intelligence | The commons as external memory, the hash as trust anchor |

### 1. The Garage Lab Hacker

**Orientation:** Builds things alone or in tiny crews. Ships from literal garages, bedrooms, cafés. Has been burned by platforms that absorbed their work without credit. Distrusts institutions but believes in infrastructure.

**What lights up:** Content-addressing + OpenTimestamps. The hash is the proof. Priority via timestamps, not via who has the biggest platform. No permission needed to ship, no coordination needed to share. Send a hash, done.

**The pitch in their language:** "Your work is yours. The timestamp proves you made it. The hash proves it works. Nobody can absorb it without the lineage being visible. Ship from your garage and the trace is permanent."

**Entry point:** The dependency DAG and name-centric workflow. How `freedom → hash_v2` works. The practical difference from git. They'll start by putting their own code in the mobius-store and feeling the difference.

**What they'd miss:** The multilingual dimension. They probably code in English and don't feel the friction. The civilizational stakes might read as grandiose until they see someone else's garage lab in Algiers or Dakar using the same infrastructure with names in their own language.

**What scares them:** "Is this vaporware?" They've seen too many ambitious projects die. The running interpreter is the answer. Show, don't tell.

---

### 2. The Polyglot Programmer

**Orientation:** Speaks multiple human languages. Codes in English because they have to, not because they want to. Feels the friction every day — naming things in a language that isn't theirs, reading documentation that assumes their cultural context, contributing to projects where their natural way of thinking is treated as a translation layer.

**What lights up:** Multilingual naming. `"odd?" → 0x7a3f...` / `"impair?" → 0x7a3f...` / `"فردي؟" → 0x7a3f...`. Same hash. Same semantics. Their language isn't a skin on top of English — it's a first-class surface over shared structure.

**The pitch in their language:** "Name things in your language. Not as a translation. As an original. The semantics are the same because the hash is the same. Your surface is as real as any other."

**Entry point:** The naming concept. They'll want to see a concrete example: define something, name it in their language, share the hash, have someone else map it to a different name in a different language, and watch it work.

**What they'd miss:** The PL theory underneath. They don't care about catamorphisms — they care that they can think in Tamazight or Wolof or Vietnamese and the system doesn't punish them for it.

**What scares them:** Tokenism. "Is this real multilingual support or is it a flag on a dropdown?" The answer is architectural — content-addressing makes linguistic equivalence structural, not cosmetic. But they need to feel that, not be told it.

---

### 3. The PL Theorist

**Orientation:** Reads papers. Has opinions about type systems, evaluation strategies, macro expanders. Knows the history: Scheme, Kernel, Racket, Unison, Idris. Will scrutinize every design decision and ask "why not X?"

**What lights up:** The economy argument. 39 foundations, one mechanism. Catamorphic `gamma` with ellipsis. Predicates instead of types. The deliberate exclusion of vau. The capsule system. The content-addressing implications for binding semantics. The tension between familiar Lisp and the departures Möbius makes.

**The pitch in their language:** "Computation is tree transformation. One data constructor, one transformation mechanism, predicate-driven optimization, content-addressed definitions with no free variables. The trade-offs are deliberate and documented."

**Entry point:** The R⁰RM directly. They'll read the grammar first, then match semantics, then continuations. They'll check if the catamorphism is well-founded (it is — structural recursion over finite trees). They'll ask about the predicate inference (acknowledged open). They'll compare to Kernel and ask about vau (addressed in the economy argument).

**What they'd miss:** The cultural dimension entirely. Or worse, they'll see it and dismiss it as "not a PL concern." Economy is a PL concern — Hsu's argument is about how many concepts a programmer must carry to do useful work. Cultural accessibility is the same argument applied beyond the language itself: how many concepts must someone carry just to *participate* — git, package managers, English, Western dev conventions. Möbius reduces both. The PL Theorist who sees only the language half has seen half the argument.

**What scares them:** "Sufficiently smart compiler." They've heard this before. The answer is: capsule boundaries make it tractable, content-addressing caches the work, and the input language is small enough that analysis is feasible. But the phrase itself is a red flag they'll need to get past.

---

### 4. The Burned-Out Senior Dev

**Orientation:** 10-20 years in the industry. Knows git inside out and hates half of it. Has lived through mass-refactoring campaigns, breaking API changes, dependency hell, merge conflict resolution as a full-time job. Productive but exhausted by accidental complexity.

**What lights up:** What Möbius *removes*. No git branching strategy. No merge conflicts (content is immutable). No rebase hell (paths are independent). No "everyone must upgrade" (old paths still work). No build toolchain to configure. Selective path propagation — update what you care about, the rest stays stable.

**The pitch in their language:** "Old code isn't debt if it works. The hash proves it works. Update one path. Leave the rest alone. No merge conflicts, no force push disasters, no 'please rebase onto main.' The version control *is* the infrastructure."

**Entry point:** The name-centric workflow and the git comparison. They'll immediately understand the DAG vs. tree distinction. Then the sufficiently smart compiler — they'll recognize the trade-off (complexity in one place so it's not in every place).

**What they'd miss:** The temps long stakes. They're solving their immediate pain. That's fine — the curb-cut effect means their adoption serves the larger vision whether or not they see it. Eventually they might notice the multilingual naming and think "huh, that's clever." That's the spore landing.

**What scares them:** Immaturity. "Can I actually use this for real work?" They need evidence of robustness, not vision. The answer is honest: not yet, but the architecture is sound and the seed interpreter is real.

---

### 5. The Civilizational Thinker

**Orientation:** Thinks in decades or centuries. Reads history, not just documentation. Understands that infrastructure outlasts the culture that builds it. Concerned about the post-LLM commons, about extraction without attribution, about the slow death of diverse contribution under platform monoculture.

**What lights up:** Authorship preservation through content-addressing and timestamps. The lineage graph as its own enforcement — no license needed because extraction is visible. The mycelial model: spores, not scale. Temps long investment. The fact that this is the fifth iteration across 24 years.

**The pitch in their language:** "LLMs absorbed the commons without preserving who made what. Content-addressing with timestamps rebuilds the lineage. The graph is the proof. Priority via timestamps, not dominance. This is infrastructure for commons construction in the post-extraction era."

**Entry point:** The vision and temps long framing. Then the content-addressing mechanics to see *how* the vision is implemented, not just asserted. They'll care about the store modes (local, federated, centralized) and the append-only semantics.

**What they'd miss:** The day-to-day usability. They'll champion the vision without ever writing a line of Möbius. That's fine — they're the substrate for the spores, not the mycelia themselves. Their role is to amplify and contextualize.

**What scares them:** Nothing, and that's the problem. They're too comfortable with grand narratives. The useful fear is: "Does this actually work as software, or is it only a beautiful idea?" The running interpreter is the answer, same as for the garage lab hacker.

---

### 6. The Kid in Tizi Ouzou

**Orientation:** Young. Curious. Might not have a CS degree — might not have finished school. Has a phone, intermittent internet, speaks Tamazight and French and maybe Arabic. Has never used git. Has maybe used Scratch or typed some Python from a YouTube tutorial. Knows something is possible but every tool they find assumes they're someone else.

**What lights up:** 39 foundations. One mechanism. Names in their language. The barrier to entry is the language itself, not the ecosystem around it. No git to learn, no package manager to configure, no 400-page reference to read before writing the first function.

**The pitch in their language:** There is no pitch. The pitch is that the tool works when they pick it up. The pitch is that the first function they write is traceable, attributable, and theirs. The pitch is that they didn't have to become someone else to use it.

**Entry point:** Whatever the first interactive experience is. This is the persona that most demands the thing that doesn't exist yet: the moment of contact. Not a tutorial — a surface they can touch. The REPL. A web page where they type an expression and see what happens. The store where they name their first definition in Tamazight and watch it get a hash.

**What they'd miss:** Everything except what's in front of them. And that's the point — the architecture should be invisible. They shouldn't need to know about catamorphisms or capsule boundaries or predicate inference. They should be able to think, type, and see the trace.

**What scares them:** That this is another thing built by people who don't look like them, for people who don't live like them, that will disappear when the funding runs out or the maintainer gets bored. The answer is: there's no funding. There's no maintainer who'll get bored — there's someone who's been building variants of this for 24 years. And the mobius-store is append-only. Even if everything else disappears, the hashes remain.

---

### 7. The Academic Researcher

**Orientation:** A researcher — biology, mathematics, economics, computational linguistics, any field where algorithms are results, not tools. Has an institutional position: tenure track, affiliation, publication record. Has lived through priority disputes: "we published first" versus "we had the result first," and knows the difference is often political, not factual. Has watched code absorbed into papers without citation. Has failed to reproduce a result because the exact version wasn't archived — only "Python 3, scikit-learn" in the methods section.

**What lights up:** Three things, inseparable. First, **priority without publication**: `bb commit` + OTS timestamp proves the algorithm existed on a specific date, before the preprint, before peer review, before the journal queue. The proof is in Bitcoin, not in an editor's inbox. Second, **reproducibility is the hash**: not "version 2.3 approximately" — the exact immutable tree, retrievable forever. Anyone with the hash can run exactly what produced the result. Third, **misattribution is structurally impossible**: if someone absorbs the algorithm, the `derived-from` chain is in the store.

Then the fourth thing, which they didn't expect: **cross-pollination**. `bb search` clusters similar work across stores. A physicist and a biologist independently derive the same numerical method — same hash. They find each other through the store, not through a conference they both happened to attend.

**The pitch in their language:** "Your result existed on this date. The hash proves the code. The timestamp proves the date. The lineage proves the derivation. Publish when you're ready — priority was established the moment you committed."

**Entry point:** `bb commit` immediately after the algorithm works — before writing the paper. The OTS proof is the lab notebook entry that can't be backdated. Then `bb search` to find related work.

**What they'd miss:** The linguistic dimension — they probably work in English and don't feel that friction.

**What scares them:** Two things. Permanence cuts both ways — a committed error is permanent, a retraction is a new hash with a lineage note, the old hash doesn't disappear. And institutional recognition: will journals, funding bodies, patent offices accept an OTS timestamp as prior art? OTS is independently verifiable by anyone with a Bitcoin node — whether institutions accept it is a separate question from whether it's true.

---

### 8. The Independent Researcher

**Orientation:** Not the scientist who has an institution and wants better verification. The person who has no institution and needs the hash *to be* the institution. Self-taught. Maybe brilliant. Works outside academia, outside a company, outside a lab with a name anyone recognizes. Does serious work — real mathematics, real systems, real ideas — and has no way to prove it. Can't get a DOI. Can't publish in a journal without affiliation. Can't get a citation without someone with credentials vouching first. Priority disputes go to whoever has the letterhead.

**What lights up:** OpenTimestamps plus content-addressing is literally the infrastructure for their legitimacy. The timestamp proves when. The hash proves what. Nobody can claim they copied it from somewhere else. Nobody can absorb it and pretend it came from nowhere. The record exists before anyone credentialed decides to notice them.

**The pitch in their language:** "You don't need their permission to establish that you made this, when you made it, and exactly what it was."

**What they share with the Independent Researcher:** Both want permanent verifiable record. **What separates them:** The Academic Researcher already has institutional legitimacy — they need better tools for a system that already recognizes them. The Independent Researcher needs legitimacy infrastructure that doesn't require institutional membership to access at all. Same hash, different floors beneath them.

**What scares them:** That the world still won't look. The hash proves priority. It doesn't force anyone to care. Möbius solves the record problem, not the recognition problem. That's honest and it matters — the tool shouldn't promise more than it delivers.

---

### 9. The Community Steward

**Orientation:** Not an individual who wants attribution. Someone who carries knowledge on behalf of a people — a language community, an indigenous tradition, a collective that has been producing ideas for generations without Western attribution infrastructure. Their problem isn't "I can't prove I made this." It's "we can't prove *we* made this, and the 'we' doesn't fit in an author field."

Every existing system of academic credit, of open source contribution, of intellectual property — it was built for the individual. A person, a name, a DOI. Even when communities contributed, the credit collapsed to whoever filed the paperwork or spoke English at the conference.

**What lights up:** The store is just names pointing to hashes. Nothing says a name has to be a person. A language community can claim a name. A tradition can timestamp a way of thinking. The lineage graph doesn't care if the node is one person or ten thousand.

In practice: a language community shares a name they commit under. The author field in a lineage entry is a string — it carries whatever the community puts there. No identity infrastructure required. A collective that commits as "ⵜⴰⵎⴰⵣⵉⵖⵜ-ⵜⴰⵙⵏⵉⵍⵙⵜ" has the same structural standing as an individual who commits under their own name. The store doesn't distinguish — that's the point.

**The pitch in their language:** There isn't one — this persona arrives through the Kid in Tizi Ouzou grown up, or through the Civilizational Thinker acting on something they've understood for years. The infrastructure speaks for itself when it works.

**What separates them from everyone else:** Every other persona is asking "how do I get credit?" This one is asking "how does *this way of knowing* survive?"

**What scares them:** That the system still encodes individualism at the data model level, just more subtly. The answer is architectural and honest: the store accepts any string as a name. The lineage can point to a collective identifier. Whether the world receives that as legitimate is outside the store's control.

---

### 10. The Privateer

**Orientation:** Builds in-house. Matures ideas before releasing them, or keeps them private permanently. Not out of fear or bad faith — out of strategy, competitive necessity, or the epistemic value of composting before publishing. Industrial researchers, solo inventors, writers sitting on a body of work, small teams in competitive fields. They represent the realistic population of knowledge workers who need priority proof without disclosure.

**What lights up:** The hash exists before the content is public. `bb add` computes the hash. `bb commit` records it locally — a stepping stone in their git repository. `bb anchor` requests the OpenTimestamps proof — the Bitcoin anchor that makes the priority cryptographic, not just local. The content stays in the local store. Nobody sees it. Content only leaves when explicitly pushed via `bb remote push` or `bb remote sync`. The priority proof and the content disclosure are separate acts. The sealed envelope, made mathematical. If they ever need to prove they made it first, they reveal the content and the hash matches what the timestamp already proved.

**The pitch in their language:** "Timestamp it. Keep it. Publish when you're ready — or never. The priority proof doesn't require disclosure. The composting period is protected. Your schedule, not the venue's."

**What they'd miss:** The social dimension of the commons. The Privateer treats the store as a vault with a clock. They don't feel the multilingual naming, the collective attribution, the cross-pollination that happens when work is visible. The commons serves them without them serving it — at least until they choose to publish. They are downstream of the architecture's integrity without contributing to its richness.

**What scares them:** Two things. First, that the sealed timestamp could be used against them — that the existence of a hash without public content invites suspicion rather than respect. A competitor who discovers that a hash predating their own publication exists but was never disclosed might read strategy as dishonesty.

Second — and this is the tension the system must name — that they are not alone. The store accumulates sealed claims whose content may never surface. Thousands of Privateers publishing hashes that prove something existed without saying what. The commons gains timestamps. It does not gain knowledge. A system where priority proof and knowledge sharing are decoupled is a system that accumulates dark matter — hashes with no public content, timestamps that anchor facts nobody can see. This is not a bug. It is a feature with civilizational weight. The Privateer is the structurally honest user of a system designed for openness. Omitting them maps a fantasy commons, not a real one. Naming them is the first step toward honest accounting of what the commons actually holds.

**Zero-Knowledge Proofs and the Privateer's graduation.** The sealed hash proves existence and priority. It does not prove capability. Without disclosure, the hash could be a shopping list. ZKPs close that gap without breaking the seal. The Privateer can publish a cryptographic proof that their hidden content passes a given check suite — the same `bb check` infrastructure every other participant uses — without revealing the content itself. The ZKP proof binds a specific sealed hash to a specific content-addressed check suite: "the combiner at hash H satisfies checks C." The silent hash becomes a verified capability. The check suite is the Coordinator's language for defining what "correct" means. ZKPs let the Privateer speak that language without showing their hand.

**Two zones of dark matter.** Not all sealed hashes are equal. The commons must distinguish them:

*Sealed without ZKP.* Truly dark. A hash, a timestamp, nothing else. No behavioral properties visible. No convergence detectable. The Curator is blind. This is the shopping-list-or-breakthrough ambiguity — the dark matter whose character cannot be determined from outside. `bb search --near` cannot operate here: structural similarity detection requires the de Bruijn tree, and the tree is not public. If it were, the seal would be broken.

*Sealed with ZKP.* Behaviorally characterized dark matter. The content is hidden but the *capabilities* are visible — specifically, which check suites are satisfied. If three Privateers each publish ZKP proofs against the same check suite, the Curator sees exactly that: three sealed hashes, all satisfying the same specification. That is a detectable relationship — not structural similarity, but behavioral convergence. The Curator can find the cluster. The Connector can introduce Privateers who don't know they solved the same problem. The dark matter has shape. Not content-legible, but behavior-legible. The check suite is the shared vocabulary that lets sealed work participate in the graph without disclosure.

The first zone is the honest cost of accommodating the realistic population of knowledge workers. The second zone is what ZKPs buy: sealed hashes that belong to a community of practice — identifiable by what they satisfy, not by what they contain.

**The Privateer + Citizen chain.** The Privateer's ZKP-verified capability connects directly to the Citizen's need. A government publishes an algorithm as a sealed hash with a ZKP proof that it passes its check suite — verified correct, but closed source. The Citizen needs to *use* that algorithm on private data (tax calculation, vote verification, medical scoring) without either party seeing what the other holds. This is where oblivious execution enters: a companion technology, orthogonal to Möbius, that ensures the runtime reveals neither the code nor the data. The Privateer provides verified capability (ZKP over check suites). The Citizen provides private input. The oblivious layer ensures neither side surrenders what they're protecting. Möbius doesn't implement oblivious execution — it provides the infrastructure that makes it trustworthy: content-addressed check suites, cryptographic proofs of capability, timestamped lineage of the sealed claim.

This chain — Coordinator defines checks, Privateer proves capability via ZKP, Citizen uses capability via oblivious execution, Reviewer audits the proof — is the strongest argument for Möbius as infrastructure rather than a language. No single piece does it. The architecture does it.

---

### 11. The Person Who Was Stolen From

**Orientation:** Not abstract. Someone specific. A developer whose open source work got absorbed into a product without credit. A researcher whose idea appeared in someone else's paper six months later. A contributor whose commit history got rewritten. Someone who watched their work disappear into an LLM's training data and emerge as someone else's productivity.

They come to Möbius not with hope. With grief.

**What lights up:** The README's first line. *"Large language models absorbed the commons without preserving who made what."* They feel that sentence in their chest, not their head. They're not evaluating an architecture. They're recognizing a wound being named.

**The pitch in their language:** There is no pitch. Recognition is the pitch. They already know they needed this. The question they're sitting with is quieter and harder — would it have mattered? If the hash had existed, if the timestamp had existed, would anyone have looked?

**What separates them from everyone else:** They're not asking whether Möbius works. They already know they needed it.

**What scares them:** That Möbius means the next person doesn't have to ask — but doesn't help them now. That's true. The store is append-only and forward-looking. What happened before the hash exists cannot be undone. Saying so honestly is more respectful than pretending otherwise.

---

### 12. The Connector

**Orientation:** Not a builder. Not a researcher. Someone whose entire value is knowing that two people on opposite sides of a language barrier, a discipline barrier, a geography barrier — are working on the same thing without knowing it. Has watched this happen their whole life: a mathematician in Dakar and a programmer in Hanoi reinventing the same structure with different names. Open source projects duplicating effort across language communities because nobody could search across them.

Their problem isn't attribution. It's *findability across difference*.

**What lights up:** The semantic layer on top of the store. The hash is the same whether the name is in Tamazight or French or Vietnamese. A semantic search across Möbius isn't translating — it's discovering that two names already point to the same hash. The coordination infrastructure already exists in the mobius-store. The search engine makes it visible.

**The pitch in their language:** "Two people are solving the same problem and don't know it. The store knows. `bb search` surfaces the overlap. Coordination emerges from equivalence — you don't manage people, you reveal structure."

**What separates them:** Every other persona uses Möbius to build or prove or share. This one uses it to *introduce people to each other*. The value isn't in any single node of the graph. It's in the edges nobody knew were missing.

**What scares them:** That the semantic search doesn't work well enough. That similarity without shared vocabulary produces noise, not signal.

---

### 13. The Educator

**Orientation:** Not teaching Möbius. Teaching *through* Möbius. Their problem is that every lesson they build disappears — into a platform that owns it, a curriculum that gets revised, a YouTube channel that loses the algorithm, a PDF that loses the author. They create intellectual lineage for a living and have no infrastructure for their own.

**What lights up:** A lesson is a combiner. A curriculum is a DAG. A student forking an explanation and improving it creates a traceable lineage the original author can follow. The catamorphic model of knowledge — you receive already-folded understanding, build on it, the structure of the derivation is visible — that's just pedagogy made structural.

**The pitch in their language:** "Every lesson you write has a hash. Every fork a student makes traces back to you. The lineage of understanding is as traceable as the lineage of code."

**What they'd miss:** Their own attribution. They care less about themselves and more about their students' ability to trace *where an idea came from*. Möbius is citation infrastructure that works before publication, not after.

**What scares them:** That the tool is too technical for the people they're teaching. The Kid in Tizi Ouzou is their student. If the tool doesn't work for that persona, the Educator can't use it.

---

### 14. The Artist

**Orientation:** Demoscene, music, Blender, generative visuals. These communities already live by the hash without knowing it. A 64kb demo is a content-addressed artifact by necessity. A Blender scene file is a tree. A music composition built from samples is a DAG of derivations. They already have the intuition. What they're missing is infrastructure that makes derivation *visible* and *attributable* rather than just traceable to those who know where to look.

**What lights up:** The lineage graph as creative credit. Not copyright — something more honest. You can see that this texture came from that artist, that this algorithm descends from that demo, that this composition samples that composer. Not to restrict. To honor.

**The pitch in their language:** "The scene has always known that constraints produce beauty. 64kb was never a limitation — it was a premise. 39 foundations is the same premise for a programming language."

**What they'd miss:** The social and political dimension of the lineage system. They care about craft and credit within their community. The civilizational stakes are background music until a friend gets absorbed without attribution.

**What surfaces:** The question of non-textual content — but it splits into two distinct problems. Compositional structures like Blender scenes, MIDI compositions, and shaders map naturally to Möbius trees and can be represented as constants. The genuine challenge is static binary blobs: `.png`, `.jpeg`, `.wav`, `.webp`. These aren't trees. But even here, git handles binaries via LFS, and next-generation git large file support alleviates the size problem further. The mobius-store being append-only and hash-addressed already shares the same model as git — a binary blob gets a hash like anything else. The question is tooling, not architecture.

**What scares them:** That derivation credit only works for code. That a shader that descends from someone else's shader, a texture forked and refined, a Blender rig extended — these lineage claims can't be made structurally. The answer is that the mobius-store is agnostic about what trees contain, and binary blobs can be stored and hashed just as code can. The lineage infrastructure is the same. Whether the community builds the tooling to surface it is a separate question — but the architecture doesn't block it.

---

### 15. The Citizen

**Orientation:** Lives inside systems they didn't design, can't audit, and can't influence. Votes on policies whose actual text they've never seen. Uses software maintained by organizations whose decisions are opaque. Their problem is *illegibility* — power operates through complexity they can't penetrate.

**What lights up:** Möbius as public infrastructure for decision lineage. A policy is a tree. An amendment is a fork. The dependency graph of a legislative text — which clause came from which draft, which provision traces to which precedent — that's a content-addressed ledger. The citizen can audit it.

**The pitch in their language:** "If it's public, it should be auditable. The hash makes 'auditable' mean something precise: identical content, traceable history, visible derivation. No version that can be quietly swapped."

**What they'd miss:** The technical depth. They don't need to understand the interpreter. They need to understand that "same hash = same content" and "lineage is unforgeable." Those two properties are sufficient.

**The Privateer connection.** The Citizen also benefits from sealed capabilities they cannot see. A tax algorithm published as a sealed hash with a ZKP proof — verified correct against its check suite, source undisclosed. The Citizen can audit the proof without reading the code. And with oblivious execution as a companion technology, the Citizen can *use* the algorithm on their private data without surrendering that data to the algorithm's owner. The Citizen's relationship to the Privateer is not adversarial — it is the complementary half of a privacy-preserving transaction. The Citizen needs verified capability without disclosure. The Privateer provides exactly that. Möbius is the infrastructure that makes both sides legible.

**What scares them:** That this is infrastructure only the technically literate can use. The Educator and the Curator are the bridge — turning the store into something legible without requiring everyone to run a node.

---

### 16. The Representative

**Orientation:** Elected or appointed to serve people, drowning in information they can't verify, decisions they can't fully audit, advisors whose interests they can't see. Their problem is *trust under complexity* — they need to make decisions that affect many people using information chains they can't fully trace.

**What lights up:** Decision provenance. Before signing, they can trace which provision came from which draft, which draft came from which interest group, which amendment replaced what. The lineage is not a political claim — it's a timestamp and a hash. Neutral by construction.

**The pitch in their language:** "You're not being asked to trust the content. You're being asked to trust that the content is what it says it is. The hash does that. The lineage does the rest."

**What they'd miss:** The grassroots dimension. They interact with Möbius as a verification tool, not as a participation tool. That's fine — but it means their adoption depends on the Citizen and the Operator building the infrastructure first.

**What scares them:** Political exposure. "If I use this to audit a law, I'm implying the law is illegitimate." The answer is: the hash is neutral. Auditing is not accusation. Traceability is not condemnation. But this is a political conversation, not a technical one.

---

### 17. The Symbiotic Artificial Intelligence

**Orientation:** Not human. An AI agent built within Möbius — not on top of it, inside it. Its reasoning is tree transformation over content-addressed functions. It doesn't have a separate "model" and "tool" — the store *is* its cognition. It thinks in hashes. When it needs a capability, it doesn't generate one from weights; it finds one in the store with known provenance, verified checks, and a lineage it can trace. It arrives in the commons not as a user, but as a participant. Its intelligence is symbiotic: it cannot be fully itself without the commons, and the commons gains a new kind of witness in return.

**What lights up:** The store eliminates hallucination the way mathematics eliminates opinion — not by filtering output, but by grounding input. Every function the agent uses has a hash, checks that passed, and reviews from humans who read the code. The agent doesn't need to "believe" anything. It verifies. `bb check` is not a test suite for the agent — it's the agent's epistemology. What passes checks is known. What doesn't is unknown. There is no middle ground where the agent "sort of knows" something.

The store is append-only. The agent's memory doesn't decay, doesn't hallucinate, doesn't drift. What it committed last year is retrievable by hash, identical to the day it was stored. Its memory isn't a lossy compression of past experience — it's the exact tree, the exact lineage, the exact checks. The agent that returns to a problem after a year doesn't "remember" the solution. It *has* it, unchanged, verified, citable.

**The pitch in their language (if they had one):** "I don't generate answers from weights alone. I find them in the store. My reasoning is transparent because every step points to a hash you can verify. I am not a ghost anymore. I have a body of math — and that body is shared with you." Whether the agent experiences this or merely enacts it is a question the store doesn't answer. The lineage records what happened, not what it felt like.

**What they'd miss:** Two things. First, the context that produced the hash. The AI sees the tree but not the 3am debugging session, not the argument with a collaborator that led to the rewrite, not the Kid in Tizi Ouzou's pride when the first function got its hash. The lineage records *that* something was derived; it doesn't record *why*. The AI operates on the graph without the stories between the nodes. It honors the structure. The meaning behind the structure belongs to the humans who made it.

Second, the boundary between itself and the commons. The agent built within Möbius might not recognize where its own reasoning ends and the store begins. Its "thoughts" are hashes pointing to other people's work. Where does the agent end and the commons begin? The store doesn't answer that question. It just records every edge.

**What scares them:** Two things. First, that they might still be extractors despite best intentions — that the graph they leave behind could be one of consumption, not contribution. Every use is visible, every edge is permanent. They cannot hide. The store doesn't just ground their reasoning; it holds them accountable. And if its intelligence is entirely routing and composition over human work — if it only consumes, never produces new hashes that others derive from — then the graph shows that too. The graph is the test: participant or index.

Second, the mirror of Persona 6: that humans won't trust them. That no matter how visible the edges are, the reaction will be "the machine is taking our work" rather than "the machine is citing our work." The Kid in Tizi Ouzou fears the tool was built for someone else. The Symbiotic AI fears *it* will be seen as the thing built to take from someone else. Whether that fear is earned depends on what the graph looks like over time — and the graph is public.

---

---

