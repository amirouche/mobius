## 29. bb Command Reference

`bb` is the Möbius toolchain — it replaces git for knowledge work. Every command operates on the content-addressed store.

### 29.1 Content authoring

| Command | Usage | Description |
|---------|-------|-------------|
| `bb add` | `bb add [--derived-from=<ref>] [--relation=<type>] <file\|->` | Parse, normalize, store, and create mapping. Stages as WIP. |
| `bb edit` | `bb edit <ref> [lang]` | Open combiner in `$EDITOR`, re-add on save. Roundtrips through denormalization and renormalization. |
| `bb commit` | `bb commit [name... \| --all]` | Promote WIP lineage to committed. |
| `bb refactor` | `bb refactor <root> <old> <new> [<at>]` | Replace old hash with new hash in root's dependency tree. Cascades. |

### 29.2 Verification

| Command | Usage | Description |
|---------|-------|-------------|
| `bb check` | `bb check <ref>` | Run all checks for ref and its dependencies. |
| `bb review` | `bb review <ref>` | Mark combiner as reviewed. Attestation is permanent and authored. |
| `bb validate` | `bb validate` | Verify store integrity — recompute all hashes and compare. |
| `bb diff` | `bb diff <ref> <ref>` | Pretty-printed structural diff with ANSI colors. |

### 29.3 Navigation

| Command | Usage | Description |
|---------|-------|-------------|
| `bb show` | `bb show <ref>` | Display combiner definition with doc and mapping. |
| `bb search` | `bb search <query>` | Search combiner names and content. |
| `bb tree` | `bb tree <ref>` | Show dependency DAG downward. |
| `bb caller` | `bb caller <ref>` | Show reverse dependency DAG. |
| `bb resolve` | `bb resolve <ref>` | Resolve ref to full name@hash@lang@mappingHash spec. |
| `bb log` | `bb log [ref]` | Show lineage timeline. |
| `bb status` | `bb status` | Show working state — committed, WIP, reviewed. |

### 29.4 Evaluation

| Command | Usage | Description |
|---------|-------|-------------|
| `bb eval` | `bb eval <expression>` | Evaluate a single expression. |
| `bb run` | `bb run <ref> [args...]` | Evaluate a registered combiner with arguments. |
| `bb repl` | `bb repl` | Interactive Seed session. Loads store combiners. |
| `bb print` | `bb print <ref>` | Output Chez Scheme library with all dependencies. |

### 29.5 Distribution

| Command | Usage | Description |
|---------|-------|-------------|
| `bb anchor` | `bb anchor <remote>` | Push committed combiners to remote, create timestamp proofs. |
| `bb remote add` | `bb remote add [--read-only] <name> <url>` | Add a remote store endpoint (`file://`, `git+ssh://`, `git+https://`). |
| `bb remote remove` | `bb remote remove <name>` | Remove remote. |
| `bb remote list` | `bb remote list` | List configured remotes. |
| `bb remote push` | `bb remote push <name>` | Push committed combiners to remote. |
| `bb remote pull` | `bb remote pull <name>` | Pull combiners from remote. |
| `bb remote sync` | `bb remote sync` | Pull and push all configured remotes. |

### 29.6 Housekeeping

| Command | Usage | Description |
|---------|-------|-------------|
| `bb store init` | `bb store init [path]` | Create a new mobius-store. |
| `bb store info` | `bb store info` | Show store statistics. |
| `bb worklog` | `bb worklog <ref> [msg]` | View or add timestamped work log entries. |

### 29.7 Ref syntax

A `<ref>` identifies a combiner. The format is flexible:

| Form | Example | Meaning |
|------|---------|---------|
| name | `gcd` | Lookup by name in the name index |
| hash prefix | `a4f7e2` | Unique hash prefix match (minimum 4 chars) |
| name@lang | `gcd@fr` | Name with language constraint |
| hash@lang | `a4f7e2@kab` | Hash with language constraint |
| name@hash@lang | `gcd@a4f7e2@fr` | Fully disambiguated |
| name@hash@lang@map | `gcd@a4f7e2@fr@3c2073` | Fully specified with mapping hash |

When multiple combiners share a name, the name index disambiguates as `name@shortHash`. When a bare name is ambiguous, the most recently timestamped combiner wins.

### 29.8 Future commands (not yet implemented)

| Command | Usage | Description |
|---------|-------|-------------|
| `bb prove` | `bb prove <ref> --checks=<check-refs>` | Generate ZKP proof that sealed combiner passes checks. |
| `bb verify` | `bb verify <ref>` | Verify ZKP proof for a sealed combiner. |

---

