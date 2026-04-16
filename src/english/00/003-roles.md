## 3. Roles

*The following are not personas — they are roles any of the above personas may perform. They are defined by a workflow and a set of bb commands, not by who a person is or what brought them to Möbius. A persona is an entry point. A role is a mode of participation.*

**What anyone can do once here — the 7 roles:**

| Role | Workflow | Skill |
|------|----------|-------|
| Author | `bb edit`, `bb check`, `bb commit`, `bb refactor` | Writing content, declaring lineage |
| Forker | `bb edit hash@lang`, `bb check`, `bb commit` (derived-from) | Making derivation explicit |
| Maintainer | `bb check`, `bb diff`, `bb review --status`, `bb refactor` | Keeping the graph honest |
| Linguistic Contributor | `bb add name file target-language` | Language and meaning |
| Reviewer | `bb review` | Trust and accountability |
| Curator | `bb search` | Pattern recognition, legibility |
| Coordinator | `bb add` (checks) | Problem definition |
| Operator | `bb sync`, `bb remote` | Redundancy, survival |

---

## How Roles Relate

The roles are not a hierarchy. They are a loop.

**Coordinator defines → Author builds → Forker derives → Maintainer propagates → Coordinator refines.**

The Coordinator writes checks — "here is what correct means." But they're writing into the dark. They don't know yet what edge cases the real world will surface.

The Author writes to those checks. `bb check` tells them if they're correct. But passing checks doesn't mean the checks were right.

The Forker discovers the edges — the cases where the original didn't quite fit, where a fix or extension was needed. Their `derived-from` makes the gap visible.

The Maintainer discovers, over time, that a check suite was incomplete. A bug that `bb check` didn't catch. A path that broke after propagation. That discovery is the signal the Coordinator needs to refine the spec.

So the loop closes: the Maintainer's work feeds back to the Coordinator. Neither role is complete without the other — not because one outranks the other, but because the system only improves if someone enforces the standard over time and reports what the standard missed.

**To get started, you only need two roles:** Coordinator and Author. One person writes checks that define the problem. One person writes content that passes them. Everything else — Forker, Maintainer, Reviewer, Linguistic Contributor, Curator, Operator — grows from that minimum viable commons.

In a garage lab, those two roles are often the same person. That's fine. The separation becomes meaningful when a second person arrives.

---

## The Personas

---


### The Author

**What they do:** Writes content into the store. Uses `bb edit identifier@lang` to open a working session, `bb check` to verify the result passes its check suites, `bb commit` to register the result as a content-addressed hash, `bb refactor` to propagate a change through dependent paths. This is the primary workflow — the role everything else depends on.

**Their contribution:** The content itself. Without the Author there is nothing to review, translate, curate, coordinate around, or mirror. Every other role is downstream.

**Key property:** In Möbius, every Author is also making a lineage decision. Writing from scratch versus deriving from an existing hash are structurally different acts. The Author who forks makes an explicit claim: *this derives from that*. That claim is permanent, visible, and timestamped. Authorship and derivation are the same gesture.

**Natural fit:** Every persona, at some point. The Garage Lab Hacker shipping from their bedroom. The Scientist committing the algorithm before writing the paper. The Kid in Tizi Ouzou writing their first function and watching it get a hash. The Author role is the entry point to everything else.

**What failure looks like:** Committing without running `bb check`. Committing without thinking about lineage. An Author who skips verification ships content whose correctness is asserted, not proven. An Author who never uses `derived-from`, who always writes "from scratch" even when they're building on prior work, degrades the lineage graph. The store can't enforce either — only the Author can. The hash proves what was made. `bb check` proves it works. Only the Author knows what it came from.

---

### The Forker

**What they do:** Doesn't write from scratch. Finds a hash in the store that does almost what they need, derives from it, names the relationship explicitly. Uses `bb edit hash@lang` to open a working session from an existing hash, `bb check` to verify the derived result passes the check suites, `bb commit` with `derived-from` and a `relation` to register the derivation. Their whole contribution is making derivation visible rather than invisible.

**Their contribution:** Edges. Every other role contributes a node to the graph. The Forker contributes the edge between nodes. Without edges the graph is just a pile of hashes. The lineage only becomes meaningful when derivation is declared — and the Forker is the person who does that consciously, as a practice.

**The `relation` enum is their vocabulary:**

| Relation | Meaning |
|----------|---------|
| `fork` | New line of work derived from existing |
| `fix` | Bug fix |
| `refine` | Improvement without changing behavior |
| `extend` | Added functionality |
| `rewrite` | Complete reimplementation |

**The two kinds of Forker — and why the distinction matters:**

The *good-faith Forker* knows they derived from something and says so. They might be the Scientist building on a colleague's numerical method, the Garage Lab Hacker refining a library function, the Artist extending a shader. They declare the relationship not because the system forces them to but because they understand that the lineage is the point. Their `derived-from` is an act of honesty and a gift to everyone downstream.

The *extraction Forker* takes your tree, renames the bindings, reorders two clauses, and commits as original work. They may be deliberately dishonest. They may genuinely believe they wrote it independently. It doesn't matter — the effect is the same: the edge that should exist doesn't, and the Person Who Was Stolen From has no structural recourse.

This is where `bb search --near identifier` stops being search infrastructure and becomes lineage integrity. At commit time, structural similarity against the corpus is computed automatically. If the new hash is close to an existing hash and no `derived-from` pointer exists, the system surfaces it — not as an accusation, as a prompt: *"this looks close to `a1b2c3...` — did you mean to derive from it?"* The good-faith Forker who forgot gets a reminder. The extraction Forker loses plausible deniability.

**What the system can and cannot do:** It can detect structural similarity. It cannot prove intent. A SimHash match with no `derived-from` is evidence, not proof. The store surfaces the gap; humans interpret it. Möbius is a diagnostic instrument, not a court.

**Natural fit:** Any persona building on existing work. The Scientist extending a prior result. The Burned-Out Senior Dev fixing a production bug in someone else's function. The Kid in Tizi Ouzou adapting a function from the store to something that fits their context.

**What scares the good-faith Forker:** False positives — being flagged for independent convergence on the same solution. Two people solving the same problem often arrive at structurally similar answers. SimHash similarity is not derivation. The system must present this as a suggestion, never a verdict. The `relation` field `rewrite` exists precisely for the case where the similarity is real but the derivation is not.

**What failure looks like:** The Forker who never uses `derived-from`. Who always commits as original work. Who uses the store's content as raw material without leaving the edge. The store cannot prevent this. The lineage graph is only as honest as the people writing into it — until `bb search --near` makes the gap visible.

---

### The Maintainer

**What they do:** Keeps the graph honest over time. No new content is produced. The Maintainer's work is entirely about paths — which names point at which hashes, and whether those pointers still reflect the best available version of the thing.

**The workflow in practice:**

```
bb review --status freedom         ;; find stale hashes in the dependency chain
bb diff a1b2c3 7a3f8b              ;; understand what changed between old and new
bb check 7a3f8b                    ;; verify new hash passes the check suites
bb refactor freedom a1b2c3 7a3f8b  ;; propagate — update paths from old to new
```

`bb check` is the step that makes the Maintainer's judgment trustworthy rather than just confident. Before propagating, the Maintainer verifies the new hash passes the check suites the old one was supposed to satisfy. Without that step, `bb refactor` is optimism. With it, the path update is defensible.

`bb check` also enables triage. Some updates are safe — the new hash passes everything the old one passed, plus more. Some are risky — the new hash passes different checks, meaning downstream consumers might break. `bb check` surfaces that before the refactor, not after.

**Key distinction from the Forker:** The Forker produces a new hash. The Maintainer propagates an existing one. The Forker's work is in `content/`. The Maintainer's work is in the naming layer — rewiring which names point where.

**Key distinction from the Operator:** The Operator ensures the store survives. The Maintainer ensures the store remains *useful*. Both are custodial. One is infrastructure; the other is gardening.

**The Coordinator connection:** The Coordinator wrote the checks that define what "correct" means. The Maintainer uses those checks to verify that "correct" still holds after propagation. The two roles are in dialogue through the check suite — the Coordinator defines the standard, the Maintainer enforces it over time.

**What makes it attributable:** Every path update is a timestamped act. `freedom → hash_v2` is a naming event with a name attached. In traditional systems, maintenance is invisible labor — the work that keeps everything running and credits nobody. In Möbius, the Maintainer's name is on every path they tend. The graph remembers who kept it honest.

**Natural fit:** The Burned-Out Senior Dev who has spent a career doing this work invisibly and knows exactly how much it costs when nobody does it. The Reviewer who, after attesting to a new hash, realizes they depend on the old one and should update their own paths. The Scientist whose collaborator shipped a fix and now needs to decide whether their own downstream work should adopt it.

**What failure looks like:** Two kinds. The Maintainer who propagates too aggressively — updates every path to the latest hash without checking whether the change is appropriate for every consumer. Selective propagation exists for a reason; not every downstream path should move just because a better version exists. And the Maintainer who never propagates — lets stale references accumulate, lets the gap between "what the store contains" and "what paths point to" grow until it becomes archaeology rather than maintenance. The second failure is quieter and more common.

**The invisible labor problem:** There is a risk that Maintainer work remains undervalued even with attribution, because the contribution is absence of rot rather than presence of something new. A timestamped path update is less legible than a new content hash. The system records it; whether the community learns to value it is a cultural question, not a technical one. Naming the role explicitly is the first step. The fact that maintenance has historically been made invisible — collectivized, feminized, unattributed — is not incidental. Möbius making it attributable is a small structural correction to a large historical pattern.

---

### The Linguistic Contributor

**What they do:** Creates language mappings for existing functions. Uses `bb add name file target-language` to add a name-mapping in their language — variable names, function name, documentation — to a function whose hash is already in the store.

**Their contribution:** Independently content-addressed in `mappings/`, with its own lineage entry and timestamp. A good mapping is a real intellectual contribution, not a label. Naming is meaning.

**Key properties:** Mappings are forkable (multiple mappings per language per function can coexist). Authorship is permanent (lineage traces every mapping to its creator).

**Natural fit:** The Polyglot Programmer. The Scientist working in a non-English research community. The Community Steward naming a function in a language that has never had a name for that concept.

**What failure looks like:** Mappings that are technically correct but culturally empty — transliteration instead of translation, English concepts with foreign phonetics. The Linguistic Contributor at their worst imports the hegemony they were supposed to bypass.

---

### The Reviewer

**What they do:** Audits and attests to existing content. Uses `bb review <identifier>` to walk a dependency DAG interactively, marking each hash as reviewed or not. Their attestation accumulates in `reviewed/` — content-addressed, timestamped, permanently associated with their name.

**Their contribution:** Not code, not a mapping — a signed assertion: *I read this. I vouch for it.* Ten reviews from ten trusted people on the same hash carries different weight than zero reviews. After a `bb refactor`, `bb review --status` shows which new hashes have no attestations yet. Trust resets with content, as it should.

**Their skill is judgment under responsibility** — the willingness to attach their name to an assertion about someone else's work.

**Key property:** A careless approval is permanently associated with their name. The system makes accountability structural, not aspirational.

**Natural fit:** The Burned-Out Senior Dev reviewing before production. The Scientist attesting to another lab's algorithm. The Garage Lab Hacker vouching for a collaborator's work.

**What failure looks like:** Rubber-stamping. A Reviewer who attests without reading degrades the signal. Unlike code, there's no automated check for whether a review was genuine. The reputation mechanism only works if reviewers treat their name as something worth protecting.

---

### The Curator

**What they do:** Reads code, surfaces patterns, organizes the store. Uses `bb search` to discover that independent groups converged on the same checks or produced structurally similar functions.

**Their contribution:** Legibility. Making the store navigable, finding redundancy, surfacing clusters. A Curator might notice that three unrelated contributors wrote functions with the same de Bruijn hash — identical solutions discovered independently — or that a dozen functions across five stores all reference the same check suite, revealing an implicit community of practice.

**Key property:** The Curator is retrospective — they work with what already exists. Their skill is pattern recognition and legibility: understanding code, recognizing structural similarity, linking discoveries to existing knowledge. They don't write new functions. They make visible what the store already contains but no one has yet seen as a whole.

**Natural fit:** The PL Theorist recognizing a known pattern across unfamiliar implementations. The Scientist finding convergent results across disciplines. The Connector identifying the edges nobody knew were missing.

**What failure looks like:** Organizing noise instead of signal. A Curator who clusters by surface similarity rather than semantic equivalence creates false connections.

---

### The Coordinator

**What they do:** Writes checks — specifications that define problems. Uses `bb add` to register check suites: predicates that a correct solution must satisfy. A well-written check suite is a problem statement.

**Their contribution:** Functions cluster around it over time. Independent contributors write solutions, each tested against the same checks, each producing its own hash. Coordination is emergent — the Coordinator doesn't manage people, they define the problem space. When two contributors in different cities pass the same check suite, the store reveals the overlap without either of them coordinating directly.

**Key property:** The Coordinator is prospective — they define what should exist. Their skill is problem definition: specifying what "correct" means precisely enough that others can build to it. This means someone with zero code can define a problem before knowing how to solve it.

**Natural fit:** The Scientist defining the acceptance criteria for a numerical method. The Burned-Out Senior Dev writing the checks that replace a 40-page requirements document. The Kid in Tizi Ouzou defining what "correct" means for a function they need, before they know how to write it.

**What failure looks like:** Checks that encode the wrong problem. A Coordinator who specifies precisely and incorrectly creates a magnet for solutions to a problem nobody actually has. The check suite is the source of truth — if the truth is wrong, everything downstream is confidently wrong.

---

### The Operator

**What they do:** Maintains infrastructure: mirrors, remotes, sync schedules, geographic distribution. Uses `bb sync` to ensure changes in Seoul are available in Paris. Uses `bb remote` to configure replication across stores. Ensures the commons survives attacks, outages, censorship. Runs the OTS upgrade cycle so priority claims anchor in Bitcoin's proof-of-work chain on schedule.

**Their contribution:** Survival. A store with brilliant content and no mirrors is one disk failure from gone. A store with timestamps that missed the OTS upgrade window has weaker priority claims. The Operator prevents these failures.

**Key property:** The Operator doesn't need to understand what the functions do — they need to ensure the functions remain reachable. Their skill is redundancy and survival: ensuring the infrastructure persists regardless of what it contains.

**Natural fit:** The Garage Lab Hacker who runs their own mirror because they don't trust anyone else to. The Civilizational Thinker who understands that infrastructure outlasts the culture that builds it — and acts on it. The Burned-Out Senior Dev who knows from experience that what isn't redundant will eventually be lost.

**What failure looks like:** Mirroring faithfully without verifying integrity. An Operator who syncs without checking hashes propagates corruption. An Operator who lets the OTS upgrade lapse silently weakens every priority claim in their store. Operational failure is often invisible until the moment it becomes catastrophic.

---

*Same hash, different names. Same kaleidoscope, different colors.*

*The mobius-store is append-only. The hashes remain. No more ghosts.*

---

# Part II — The Language (R⁰RM)

*R⁰RM — Revised⁰ Report on Möbius*

---

