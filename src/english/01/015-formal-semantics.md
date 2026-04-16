## 19. Formal Semantics

*This chapter provides the mathematical specification of Möbius evaluation. It is normative: an implementation that disagrees with these rules is incorrect.*

### 19.1 Notation

Let *v* range over values, *e* over expressions, *ρ* over environments (finite maps from de Bruijn indices to values), and *T* range over trees (the content-addressed representation).

We write *ρ* ⊢ *e* ⇓ *v* to mean "expression *e* evaluates to value *v* in environment *ρ*."

We write *ρ*[*i* ↦ *v*] for the environment *ρ* extended with index *i* bound to value *v*.

### 19.2 Values

```
v ::= n                     (integer)
    | f                     (float)
    | c                     (character)
    | s                     (string)
    | #true | #false         (booleans)
    | #nil                   (empty list)
    | #void                  (void)
    | #eof                   (end of file)
    | (v₁ . v₂)             (pair)
    | ⟨box v⟩               (mutable box)
    | ⟨capsule τ v⟩          (capsule with type id τ)
    | ⟨combiner clauses ρ⟩  (closure)
    | ⟨continuation κ⟩       (first-class continuation)
```

### 19.3 Self-evaluation

```
─────────────── [Atom]
ρ ⊢ n ⇓ n

─────────────── [String]
ρ ⊢ s ⇓ s

─────────────── [Bool-True]
ρ ⊢ #true ⇓ #true

─────────────── [Bool-False]
ρ ⊢ #false ⇓ #false

─────────────── [Nil]
ρ ⊢ #nil ⇓ #nil
```

### 19.4 Variable lookup

```
ρ(i) = v
─────────────── [Var]
ρ ⊢ (var i) ⇓ v
```

### 19.5 Conditional

```
ρ ⊢ e₁ ⇓ v₁    v₁ ≠ #false    ρ ⊢ e₂ ⇓ v₂
──────────────────────────────────────────── [If-True]
ρ ⊢ (if e₁ e₂ e₃) ⇓ v₂

ρ ⊢ e₁ ⇓ #false    ρ ⊢ e₃ ⇓ v₃
──────────────────────────────────────────── [If-False]
ρ ⊢ (if e₁ e₂ e₃) ⇓ v₃
```

### 19.6 Gamma (combiner construction)

```
clauses = [(p₁, b₁), ..., (pₙ, bₙ)]
──────────────────────────────────────────── [Gamma]
ρ ⊢ (gamma clauses) ⇓ ⟨combiner clauses ρ⟩
```

### 19.7 Application

```
ρ ⊢ e₀ ⇓ ⟨combiner [(p₁,b₁),...,(pₙ,bₙ)] ρ'⟩
ρ ⊢ e₁ ⇓ v₁  ...  ρ ⊢ eₖ ⇓ vₖ
arg = (v₁ . (v₂ . (... . (vₖ . #nil))))
match(pⱼ, arg, self) = σ   for first matching clause j
ρ'[σ][0 ↦ self] ⊢ bⱼ ⇓ v
──────────────────────────────────────────── [Apply]
ρ ⊢ (e₀ e₁ ... eₖ) ⇓ v

where self = ⟨combiner [(p₁,b₁),...,(pₙ,bₙ)] ρ'⟩
```

### 19.8 Pattern matching

Pattern matching is defined by the function *match(p, v, self)* which returns a substitution *σ* (a map from indices to values) on success, or ⊥ on failure.

```
match(literal, v, self) = {} if literal = v, ⊥ otherwise

match((bind i), v, self) = {i ↦ v}

match((wildcard), v, self) = {}

match((catamorphic-bind i), v, self) = {i ↦ apply(self, v)}

match((guard pred (bind i)), v, self) =
    let p = apply(pred, (v . #nil)) in
    if p ≠ #false then {i ↦ v} else ⊥

match((p₁ . p₂), (v₁ . v₂), self) =
    let σ₁ = match(p₁, v₁, self) in
    if σ₁ = ⊥ then ⊥
    else let σ₂ = match(p₂, v₂, self) in
    if σ₂ = ⊥ then ⊥
    else σ₁ ∪ σ₂

match(p, v, self) = ⊥  otherwise
```

**Catamorphic termination.** Because `(catamorphic-bind i)` applies `self` only to strict structural sub-parts of the matched value, and values are finite trees, catamorphic matching always terminates. This is a structural guarantee — no proof obligation falls on the programmer.

### 19.9 Arithmetic and comparison

```
ρ ⊢ e₁ ⇓ n₁    ρ ⊢ e₂ ⇓ n₂
──────────────────────────────────────────── [Add]
ρ ⊢ (+ e₁ e₂) ⇓ n₁ + n₂
```

Analogous rules for `-`, `*`, `/` (with division-by-zero as error), `<`, `>`, `=`.

### 19.10 Cons, car, cdr

```
ρ ⊢ e₁ ⇓ v₁    ρ ⊢ e₂ ⇓ v₂
──────────────────────────────────────────── [Cons]
ρ ⊢ (cons e₁ e₂) ⇓ (v₁ . v₂)

ρ ⊢ e ⇓ (v₁ . v₂)
──────────────────────────────────────────── [Car]
ρ ⊢ (car e) ⇓ v₁

ρ ⊢ e ⇓ (v₁ . v₂)
──────────────────────────────────────────── [Cdr]
ρ ⊢ (cdr e) ⇓ v₂
```

### 19.11 Content-addressing

The *hash* function maps trees to 256-bit identifiers:

```
hash : Tree → Hash

hash(atom)     = sha256(serialize(atom))
hash(v₁ . v₂) = sha256(serialize(hash(v₁), hash(v₂)))
hash(ref h)    = h
```

**De Bruijn normalization.** Before hashing, a combiner's body is normalized: all bound variable names are replaced by positional indices. Two combiners that differ only in variable names produce the same hash.

**Registration.** A top-level definition `(define name expr)` evaluates `expr`, normalizes the result, computes its hash, stores the tree, and records the name→hash mapping.

### 19.12 TODO

The following formal rules remain to be specified:

- `begin`, `define` (nested), sequencing
- `and`, `or` (short-circuit, in terms of `if`)
- `box`, `unbox`, `box!` (mutable state)
- `call/cc`, `continuation-apply`, `guard` (control flow)
- `encapsulation-type`, capsule operations
- `display`, `assume`, `xeno`
- Error semantics (what happens when `car` is applied to an atom, when no gamma clause matches, when division by zero occurs)

---

