# Möbius Personas — Angles of Incidence

*Same kaleidoscope, different colors. Each persona sees Möbius from a different angle. None of them are wrong. None of them see the whole thing.*

---

## 1. The Garage Lab Hacker

**Orientation:** Builds things alone or in tiny crews. Ships from literal garages, bedrooms, cafés. Has been burned by platforms that absorbed their work without credit. Distrusts institutions but believes in infrastructure.

**What lights up:** Content-addressing + OpenTimestamps. The hash is the proof. Priority via timestamps, not via who has the biggest platform. No permission needed to ship, no coordination needed to share. Send a hash, done.

**The pitch in their language:** "Your work is yours. The timestamp proves you made it. The hash proves it works. Nobody can absorb it without the lineage being visible. Ship from your garage and the trace is permanent."

**Entry point:** The dependency DAG and name-centric workflow (Notes §Name-Centric Workflow). How `freedom → hash_v2` works. The practical difference from git. They'll start by putting their own code in the content store and feeling the difference.

**What they'd miss:** The multilingual dimension. They probably code in English and don't feel the friction. The civilizational stakes might read as grandiose until they see someone else's garage lab in Algiers or Dakar using the same infrastructure with names in their own language.

**What scares them:** "Is this vaporware?" They've seen too many ambitious projects die. The running interpreter is the answer. Show, don't tell.

---

## 2. The Polyglot Programmer

**Orientation:** Speaks multiple human languages. Codes in English because they have to, not because they want to. Feels the friction every day — naming things in a language that isn't theirs, reading documentation that assumes their cultural context, contributing to projects where their natural way of thinking is treated as a translation layer.

**What lights up:** The multilingual registry. `"odd?" → 0x7a3f...` / `"impair?" → 0x7a3f...` / `"فردي؟" → 0x7a3f...`. Same hash. Same semantics. Their language isn't a skin on top of English — it's a first-class surface over shared structure.

**The pitch in their language:** "Name things in your language. Not as a translation. As an original. The semantics are the same because the hash is the same. Your surface is as real as any other."

**Entry point:** The cultural accessibility section (Notes §Cultural Accessibility). The registry concept. They'll want to see a concrete example: define something, name it in their language, share the hash, have someone else map it to a different name in a different language, and watch it work.

**What they'd miss:** The PL theory underneath. They don't care about catamorphisms — they care that they can think in Tamazight or Wolof or Vietnamese and the system doesn't punish them for it.

**What scares them:** Tokenism. "Is this real multilingual support or is it a flag on a dropdown?" The answer is architectural — content-addressing makes linguistic equivalence structural, not cosmetic. But they need to feel that, not be told it.

---

## 3. The PL Theorist

**Orientation:** Reads papers. Has opinions about type systems, evaluation strategies, macro expanders. Knows the history: Scheme, Kernel, Racket, Unison, Idris. Will scrutinize every design decision and ask "why not X?"

**What lights up:** The economy argument. ~35 primitives, one mechanism. Catamorphic match with ellipsis. Predicates instead of types. The deliberate exclusion of vau. The capsule system. The content-addressing implications for binding semantics. The tension between familiar Lisp and the departures Möbius makes.

**The pitch in their language:** "Computation is tree transformation. One data constructor, one transformation mechanism, predicate-driven optimization, content-addressed definitions with no free variables. The trade-offs are deliberate and documented."

**Entry point:** The R⁰RM directly. They'll read the grammar first, then match semantics, then continuations. They'll check if the catamorphism is well-founded (it is — structural recursion over finite trees). They'll ask about the predicate inference (acknowledged as open, §15.1). They'll compare to Kernel and ask about vau (addressed in Notes §Economy).

**What they'd miss:** The cultural dimension entirely. Or worse, they'll see it and dismiss it as "not a PL concern." The Hsu principle bridges this — economy *is* a PL concern, and cultural accessibility is economy applied to the full stack from syntax to onboarding.

**What scares them:** "Sufficiently smart compiler." They've heard this before. The answer is: capsule boundaries make it tractable, content-addressing caches the work, and the input language is small enough that analysis is feasible. But the phrase itself is a red flag they'll need to get past.

---

## 4. The Burned-Out Senior Dev

**Orientation:** 10-20 years in the industry. Knows git inside out and hates half of it. Has lived through mass-refactoring campaigns, breaking API changes, dependency hell, merge conflict resolution as a full-time job. Productive but exhausted by accidental complexity.

**What lights up:** What Möbius *removes*. No git branching strategy. No merge conflicts (content is immutable). No rebase hell (paths are independent). No "everyone must upgrade" (old paths still work). No build toolchain to configure. Selective path propagation — update what you care about, the rest stays stable.

**The pitch in their language:** "Old code isn't debt if it works. The hash proves it works. Update one path. Leave the rest alone. No merge conflicts, no force push disasters, no 'please rebase onto main.' The version control *is* the infrastructure."

**Entry point:** Notes §Name-Centric Workflow and the git comparison. They'll immediately understand the DAG vs. tree distinction. Then §The Sufficiently Smart Compiler — they'll recognize the trade-off (complexity in one place so it's not in every place). They'll want to see the `mobius project enter freedom` workflow and feel how different it is from `git checkout -b feature/whatever`.

**What they'd miss:** The temps long stakes. They're solving their immediate pain. That's fine — the curb-cut effect means their adoption serves the larger vision whether or not they see it. Eventually they might notice the multilingual registry and think "huh, that's clever." That's the spore landing.

**What scares them:** Immaturity. "Can I actually use this for real work?" They need evidence of robustness, not vision. The answer is honest: not yet, but the architecture is sound and the seed interpreter is real.

---

## 5. The Civilizational Thinker

**Orientation:** Thinks in decades or centuries. Reads history, not just documentation. Understands that infrastructure outlasts the culture that builds it. Concerned about the post-LLM commons, about extraction without attribution, about the slow death of diverse contribution under platform monoculture.

**What lights up:** Authorship preservation through content-addressing and timestamps. The lineage graph as its own enforcement — no license needed because extraction is visible. The mycelial model: spores, not scale. Temps long investment. The fact that this is the fifth iteration across 24 years.

**The pitch in their language:** "LLMs absorbed the commons without preserving who made what. Content-addressing with timestamps rebuilds the lineage. The graph is the proof. Priority via timestamps, not dominance. This is infrastructure for commons construction in the post-extraction era."

**Entry point:** The vision section of the Notes (§The Vision: Temps Long). Then the content-addressing mechanics to see *how* the vision is implemented, not just asserted. They'll care about the registry modes (local, federated, centralized) and the append-only semantics.

**What they'd miss:** The day-to-day usability. They'll champion the vision without ever writing a line of Möbius. That's fine — they're the substrate for the spores, not the mycelia themselves. Their role is to amplify and contextualize.

**What scares them:** Nothing, and that's the problem. They're too comfortable with grand narratives. The useful fear is: "Does this actually work as software, or is it only a beautiful idea?" The running interpreter is the answer, same as for the garage lab hacker.

---

## 6. The Kid in Tizi Ouzou

**Orientation:** Young. Curious. Might not have a CS degree — might not have finished school. Has a phone, intermittent internet, speaks Tamazight and French and maybe Arabic. Has never used git. Has maybe used Scratch or typed some Python from a YouTube tutorial. Knows something is possible but every tool they find assumes they're someone else.

**What lights up:** ~35 primitives. One mechanism. Names in their language. The barrier to entry is the language itself, not the ecosystem around it. No git to learn, no package manager to configure, no 400-page reference to read before writing the first function.

**The pitch in their language:** There is no pitch. The pitch is that the tool works when they pick it up. The pitch is that the first function they write is traceable, attributable, and theirs. The pitch is that they didn't have to become someone else to use it.

**Entry point:** Whatever the first interactive experience is. This is the persona that most demands the thing that doesn't exist yet: the moment of contact. Not a tutorial — a surface they can touch. The REPL. A web page where they type an S-expression and see what happens. The registry where they name their first definition in Tamazight and watch it get a hash.

**What they'd miss:** Everything except what's in front of them. And that's the point — the architecture should be invisible. They shouldn't need to know about catamorphisms or capsule boundaries or predicate inference. They should be able to think, type, and see the trace.

**What scares them:** That this is another thing built by people who don't look like them, for people who don't live like them, that will disappear when the funding runs out or the maintainer gets bored. The answer is: there's no funding. There's no maintainer who'll get bored — there's someone who's been building variants of this for 24 years. And the content store is append-only. Even if everything else disappears, the hashes remain.

---

*Same hash, different names. Same kaleidoscope, different colors.*
