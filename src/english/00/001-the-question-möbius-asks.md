## 1. The Question Möbius Asks

Pariser, Rushkoff, Illich — they are all ultimately talking about education. Not schooling. The capacity to see what's shaping you, to choose your dependencies, to participate in chains of trust rather than being merely held by chains of custody.

That is what Möbius is for. Not AI, not even software in the narrow sense. It is infrastructure for that kind of seeing.

The question "can you understand enough of the chain to participate in it freely?" is exactly the question Möbius asks. Situated software. Self-served. Comprehensible. Not software you merely consume, but software whose derivation you can trace far enough to make it yours. You don't need to understand everything. You need to understand enough to be free in it rather than captured by it.

### The fog

The current software economy encodes extraction through mutable registries, invisible attribution, opaque derivation. Every programmer who thinks in Wolof, Tamil, Vietnamese, or Tamazight and codes in English pays a cognitive tax. Every variable named in a second language is a thought translated before it's expressed. This overhead is invisible to the people who don't pay it — and universal for everyone who does. Large language models absorbed the commons without preserving who made what. Content-addressing with timestamps rebuilds the lineage. The graph is the proof.

This is the Hobbesian fog: a state of affairs where the rules of the game produce extraction as their natural outcome, not because the players are malicious, but because the game rewards invisibility and punishes legibility. Mutable registries mean names can be silently repointed. Absent timestamps mean priority is political, not factual. Opaque derivation means the Person Who Was Stolen From has no structural recourse.

Möbius is a different ruleset. Playing the game — committing, timestamping, naming, forking, reviewing — produces visibility as its natural outcome. The lineage graph is its own enforcement mechanism. No license is needed for priority; timestamps and content-addressing make extraction visible.

### The premises

Möbius rests on a small number of premises:

**Computation is tree transformation.** One data constructor (`cons`). One mechanism (`gamma`). 39 foundations. The rest is the domain.

**Identity is the hash.** The same algorithm, in any human language, using any variable names, produces the identical SHA-256 hash after de Bruijn normalization. Identity is structural, not nominal.

**Priority is the timestamp.** Bitcoin-anchored OpenTimestamps proofs establish when something existed. No institution required. No permission needed.

**Derivation is structural.** Every function's lineage lives as hash pointers. The `derived-from` edge is a permanent, visible, timestamped claim. The lineage graph is append-only.

**Naming is meaning.** Names are views into content-addressed mappings. A mapping in Tamazight is as real as a mapping in English. The hash underneath is the same.

**Diversity is strength.** When it comes to humans, Möbius values diversity. When it comes to systems, Möbius values boring. The computational substrate should be invisible, enabling human and linguistic diversity above it.

### The north star

The north star persona is "the Kid in Tizi Ouzou" — young, Tamazight/French speaker, intermittent internet, no CS degree. If the system works for them, it works for everyone. Their world comes first in the interface, not as a translation of someone else's world.

### The scale

Möbius scales via the mycelium/spore model.

A fungal network grows not by one organism getting bigger, but by spores landing in new soil and growing their own local mycelium. Each mycelium is independently viable — it doesn't need the original to survive. When two mycelia connect, the network gets richer. When they don't, both still work.

In Möbius: the mycelium is a local store — hashes, mappings, lineage, checks, all functioning independently. A spore is that store landing in another garage lab. Someone sees a demo, retrieves a function by hash, runs `bb store init`, starts their own commons. They didn't join a platform. They grew their own mycelium. The protocol is the shared surface — same hashing, same de Bruijn normalization, same content-addressing — but there is no canonical instance. `bb remote sync` connects stores when people choose to connect them, not because the system requires it. Two stores that never sync are both valid. Two stores that sync discover shared hashes without either being authoritative.

This is the opposite of platform growth. No hockey stick, no network effects pulling everyone to one hub, no single point of failure. The trade-off is speed: mycelial networks grow slowly because no single node is critical. Möbius accepts that trade-off. The store is append-only. Even if everything else disappears, the hashes remain.

This is the fifth iteration across 24 years. There's no funding. There's no maintainer who'll get bored. The investment is *temps long*.

---

