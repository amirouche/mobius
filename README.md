# Möbius

Large language models absorbed the commons without preserving who made
what. Möbius rebuilds the lineage.

Twenty primitives. One mechanism. Name things in your language — not
as a translation, as an original. Share a hash, not a dependency, not
a repo, not a platform.

Computation is tree transformation. Your code is identified by its
hash, your authorship by its timestamp, and your names are yours — in
whatever language you think in.

## Same algorithm, three surfaces, one hash

An arithmetic evaluator. No explicit recursion — the fold is declared
in the pattern.

**English — curly:**

```javascript
define abacus gamma {
    case (? integer? ,n): n;
    case ("add" ,(left) ,(right)): (left + right);
    case ("sub" ,(left) ,(right)): (left - right);
    case ("mul" ,(left) ,(right)): (left * right);
    case ("div" ,(left) ,(right)): (left / right);
};

abacus(list("add" 1 list("mul" 2 3)));
;; => 7
```

**Español — spacy:**

```python
define ábaco: gamma:
    case (? entero? ,n): n
    case ("suma" ,(izquierda) ,(derecha)): (izquierda + derecha)
    case ("resta" ,(izquierda) ,(derecha)): (izquierda - derecha)
    case ("mult" ,(izquierda) ,(derecha)): (izquierda * derecha)
    case ("div" ,(izquierda) ,(derecha)): (izquierda / derecha)

ábaco(list("suma" 1 list("mult" 2 3)))
;; => 7
```

**Français — round:**

```scheme
(define abaque
  (gamma ((? entier? ,n) n)
         (("somme" ,(gauche) ,(droite)) (+ gauche droite))
         (("diff" ,(gauche) ,(droite)) (- gauche droite))
         (("produit" ,(gauche) ,(droite)) (* gauche droite))
         (("quotient" ,(gauche) ,(droite)) (/ gauche droite))))

(abaque (list "somme" 1 (list "produit" 2 3)))
;; => 7
```

Three languages. Three syntaxes. Same hash. Same result. No one
translated — they wrote originals.

## Status

R⁰RM — the Revised⁰ Report on Möbius — is the working
specification. The "0" means: the revision before revision. The seed
before the tree.

The interpreter is under construction. This is a garage lab operation
shipping approximations, not a platform shipping promises.

<!-- ## Further reading -->

<!-- - [R⁰RM — Specification](docs/r0rm.md) -->
<!-- - [Design Notes](docs/notes.md) -->
<!-- - [Personas — Angles of Incidence](docs/personas.md) -->

---

*The content store is append-only. The hashes remain.*

*"Plans are only good intentions unless they immediately degenerate into hard work." — Peter Drucker*
