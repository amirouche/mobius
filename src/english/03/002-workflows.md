## 30. Workflows

### 30.1 The basic loop

The minimum viable workflow is two roles: Coordinator and Author.

```
1. Coordinator writes checks:
   bb add checks.scm
   bb commit --all

2. Author writes implementation:
   bb add solution.scm
   bb check solution
   bb commit solution
   bb anchor origin
```

### 30.2 Edit-check-commit

The `bb edit` workflow for iterative refinement:

```
bb edit gcd            # opens in $EDITOR with doc, definition, and checks
                       # on save: parse → eval → run checks
                       #   all pass → re-add to store
                       #   any fail → (d)iscard, (w)orklog, (r)e-edit
bb commit gcd
```

### 30.3 Fork and derive

Building on someone else's work:

```
bb edit existing-fn         # read the existing implementation
# write your version in a new file
bb add --derived-from=existing-fn --relation=extend new-fn.scm
bb check new-fn
bb commit new-fn
```

### 30.4 Refactor propagation

When a dependency is updated:

```
bb diff old-dep new-dep          # understand what changed
bb check new-dep                 # verify new version passes checks
bb refactor my-fn old-dep new-dep  # propagate through dependency tree
bb commit --all
```

### 30.5 The Privateer workflow

Priority without disclosure:

```
bb add secret-algo.scm           # hash computed locally
bb commit secret-algo             # committed locally
bb anchor origin                  # OTS timestamp anchored in Bitcoin
# content stays local — never pushed
# later, optionally:
bb prove secret-algo --checks=~check-spec  # ZKP proof (future)
bb remote push origin --proofs-only         # push only the proof
```

### 30.6 Multilingual contribution

Adding a mapping in another language:

```
bb add gcd.kab.scm kab           # same algorithm, Tamazight names
bb show gcd@kab                  # verify the mapping reads correctly
bb commit --all
```


---

# Part V — Horizon

---

