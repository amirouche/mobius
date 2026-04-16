## 12. Capsules

A capsule type is defined by an integer smaller than 2¹²⁸ serving as a type identifier. The foundation `encapsulation-type` takes this integer and returns a tree of three combiners: a constructor, a predicate, and an accessor.

The base library provides convenience combiners for extracting these (§17.2):

**Round:**
```scheme
(define my-type (encapsulation-type 0x9f3a7b2c4d5e6f708192a3b4c5d6e7f8))
(define make-my (capsule-constructor my-type))
(define my? (capsule-predicate my-type))
(define unwrap-my (capsule-unwrap my-type))
```

**Curly:**
```javascript
define my-type encapsulation-type(0x9f3a7b2c4d5e6f708192a3b4c5d6e7f8);
define make-my capsule-constructor(my-type);
define my? capsule-predicate(my-type);
define unwrap-my capsule-unwrap(my-type);
```

**Spacy:**
```python
define my-type: encapsulation-type(0x9f3a7b2c4d5e6f708192a3b4c5d6e7f8)
define make-my: capsule-constructor(my-type)
define my?: capsule-predicate(my-type)
define unwrap-my: capsule-unwrap(my-type)
```

**Constructor**: wraps any tree in an opaque capsule tagged with this type ID.

**Predicate**: returns `#true` if a value is a capsule with this type ID, `#false` otherwise.

**Accessor**: unwraps the capsule, returning the inner tree. Fails if the value does not have this type ID.

The raw result of `encapsulation-type` is a tree `(constructor . (predicate . (accessor . #nil)))` — the library combiners are shorthand for `car`, `car` of `cdr`, and `car` of `cdr` of `cdr`.

### 9.1 Non-generative types

Capsule types are **non-generative**: the same integer anywhere defines the same type. Two modules using the same ID have compatible types. Two modules using different IDs have incompatible types, even if structurally identical.

The type identifier is an integer — it lives in the content store like any other data. There is no runtime generation of fresh types.

**Collision.** Because type identifiers are chosen by the programmer, two unrelated capsule types may accidentally share the same ID. This is a bug, not a feature. Linting tools should detect duplicate type IDs across a codebase. The question of how to derive type IDs safely is an open question (Chapter 33).

### 9.2 Capsules and predicates

A capsule's predicate is its type. There is no separate type declaration language. A type is a question: does this value satisfy this predicate?

Predicates compose freely. A value may satisfy multiple predicates without any hierarchical relationship. There is no inheritance, no class hierarchy. Classification is external and open.

### 9.3 Capsules and mutability

A capsule wraps any value — including boxes. If a capsule contains a box (or a tree containing boxes), the capsule's contents are mutable through `box!`. The capsule itself is opaque and cannot be swapped out, but boxes inside it can be mutated.

A capsule wrapping only atoms and pairs is immutable. A capsule wrapping a box is a stateful object. The distinction is determined by what the programmer puts inside.

### 9.4 Decapsulation

Decapsulation is always explicit. Code must use the accessor to unwrap a capsule before matching on its contents. Pattern-level capsule destructuring is not supported — use a predicate guard to dispatch on type, then call the accessor in the body.

```scheme
;; round
(gamma (((? my? ,x) (do-something (unwrap-my x)))
        (,other     (do-other other))))
```

```javascript
// curly
gamma {
    case (? my? ,x): do-something(unwrap-my(x));
    case ,other: do-other(other);
}
```

```python
# spacy
gamma:
    case (? my? ,x): do-something(unwrap-my(x))
    case ,other: do-other(other)
```

