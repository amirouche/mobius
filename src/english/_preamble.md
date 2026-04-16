# The Möbius Manual

*Draft 1 — April 2026*

---

## Preface

This is a manual for Möbius: a source-available programming language, content-addressed store, and toolchain where code is stored as language-independent de Bruijn trees. The same algorithm written in Tamazight, Arabic, French, or English produces the identical SHA-256 hash. Authorship priority is established through Bitcoin-anchored OpenTimestamps proofs requiring no institution. Derivation is structural: every function's lineage lives as hash pointers, not in mutable registries.

This manual is organized in five parts:

**Part I — Who and Why** begins with the question Möbius asks, then describes the people it serves. The personas are not marketing — they are the specification. If the system doesn't work for the Kid in Tizi Ouzou, it doesn't work.

**Part II — The Language** specifies R⁰RM: 39 foundations, one mechanism (`gamma`), three surface syntaxes producing identical content-addressed trees. This part includes prose specification, formal operational semantics, and a reference test suite. An implementer reads Part II. A PL theorist reads Part II.

**Part III — The Store** specifies the content model: immutable trees, emergent naming from mappings, lineage, checks, sealed timestamps, and zero-knowledge proofs. This part is the argument that Möbius is infrastructure, not just a language.

**Part IV — The Toolchain** specifies `bb`: the command-line interface that replaces git for knowledge work. `bb edit`, `bb check`, `bb commit`, `bb refactor`, `bb anchor`, `bb prove`, `bb verify`.

**Part V — Horizon** describes what's next: oblivious execution, Atlas Stoa, open questions. These are architectural commitments that the current design accommodates but does not yet implement.

The "0" in R⁰RM: this is the revision before revision, the seed before the tree.

---

## Table of Contents

### Part I — Who and Why

1. [The Question Möbius Asks](#1-the-question-möbius-asks)
2. [Personas](#2-personas)
3. [Roles](#3-roles)

### Part II — The Language (R⁰RM)

4. [Overview](#4-overview)
5. [Values](#5-values)
6. [Three Surfaces](#6-three-surfaces)
7. [Gamma](#7-gamma)
8. [Patterns](#8-patterns)
9. [Evaluation](#9-evaluation)
10. [Define and Scope](#10-define-and-scope)
11. [Lambda](#11-lambda)
12. [Capsules](#12-capsules)
13. [Boxes](#13-boxes)
14. [Predicates and Typing](#14-predicates-and-typing)
15. [Continuations and Control Flow](#15-continuations-and-control-flow)
16. [Reader Syntax](#16-reader-syntax)
17. [Foundations and Base Library](#17-foundations-and-base-library)
18. [Grammar](#18-grammar)
19. [Formal Semantics](#19-formal-semantics)
20. [Reference Test Suite](#20-reference-test-suite)

### Part III — The Store

21. [Content Model](#21-content-model)
22. [Naming](#22-naming)
23. [Registration](#23-registration)
24. [Combiner Structure](#24-combiner-structure)
25. [Lineage](#25-lineage)
26. [Checks](#26-checks)
27. [Sealed Timestamps](#27-sealed-timestamps)
28. [Zero-Knowledge Proofs](#28-zero-knowledge-proofs)

### Part IV — The Toolchain

29. [bb Command Reference](#29-bb-command-reference)
30. [Workflows](#30-workflows)

### Part V — Horizon

31. [Oblivious Execution](#31-oblivious-execution)
32. [Atlas Stoa](#32-atlas-stoa)
33. [Open Questions](#33-open-questions)

### Annexes

A. [Ellipsis (Possible Future Addition)](#annex-a-ellipsis)
B. [Predicate-Driven Optimization](#annex-b-predicate-driven-optimization)
C. [Representation Inference](#annex-c-representation-inference)
D. [Knowledge Economy](#annex-d-knowledge-economy)
E. [Abacus — An Arithmetic Evaluator](#annex-e-abacus)
F. [Historical Changelog](#annex-f-historical-changelog)

---

