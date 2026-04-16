## 7. Gamma

`gamma` is the core foundation of Möbius. It takes a sequence of clauses and returns a combiner.

### 4.1 Basic form

**Round:**
```scheme
(gamma (pattern₁ body₁)
       (pattern₂ body₂)
       ...
       (patternₙ bodyₙ))
```

**Curly:**
```javascript
gamma {
    case pattern₁: body₁;
    case pattern₂: body₂;
    ...
    case patternₙ: bodyₙ;
}
```

**Spacy:**
```python
gamma:
    case pattern₁: body₁
    case pattern₂: body₂
    ...
    case patternₙ: bodyₙ
```

The resulting combiner accepts a single tree argument, tries each pattern in order, and evaluates the body of the first matching clause.

### 4.2 Catamorphism

When a pattern uses `,(x)`, the enclosing gamma combiner is applied to the subtree recursively before binding. The body receives already-folded values. The programmer never writes an explicit recursive call.

**Round:**
```scheme
(define sum (gamma ((,head . ,(tail)) (+ head tail))
                   (#nil               0)))
(sum (list 1 2 3))
;; => 6
```

**Curly:**
```javascript
define sum gamma {
    case (,head . ,(tail)): (head + tail);
    case #nil: 0;
};
sum(list(1 2 3));
// => 6
```

**Spacy:**
```python
define sum: gamma:
    case (,head . ,(tail)): (head + tail)
    case #nil: 0
sum(list(1 2 3))
# => 6
```

Here `head` is bound to the raw car. `tail` is bound to the result of applying `sum` to the cdr. The fold is declared in the pattern, not the body.

Because recursion is limited to structural sub-parts of the matched value, catamorphic match over finite structures always terminates.

