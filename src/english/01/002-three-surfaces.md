## 6. Three Surfaces

Möbius has three surface syntaxes. All three produce identical content-addressed trees. The surface is a view; the content is the truth.

### 3.1 Surface declaration

A Möbius source file uses the extension `.mobius` and begins with a surface declaration:

```
#lang round
#lang curly
#lang spacy
```

If absent, behavior is implementation-defined. The surface can also be selected via command-line flag: `--surface=round`, `--surface=curly`, `--surface=spacy`.

### 3.2 Round surface

Round is the S-expression surface. Prefix notation. Parentheses delimit everything.

```scheme
#lang round

;; constants
(define pi 3.14)

;; combiners with lambda
(define double (lambda (x) (* x 2)))

;; combiners with gamma
(define sum (gamma ((,head . ,(tail)) (+ head tail))
                   (#nil               0)))

;; application
(sum (list 1 2 3))

;; conditional
(if (> x 0) (+ x 1) (- x 1))

;; sequencing
(begin (display "hello") (display "world") 42)

;; list construction
(list 1 2 3)             ;; => (1 . (2 . (3 . #nil)))
(cons 1 (cons 2 #nil))   ;; => (1 . (2 . #nil))
```

Comments: `;` for line comments, `#;` for datum comments.

**No anonymous combiners as arguments.** Every `gamma` or `lambda` must be bound to a name via `define`. This ensures surface equivalence — any program written in round can be identically expressed in curly and spacy.

```scheme
;; WRONG — anonymous combiner as argument
(map (lambda (x) (* x 2)) my-list)

;; CORRECT — named combiner
(define double (lambda (x) (* x 2)))
(map double my-list)
```

### 3.3 Curly surface

Curly uses braces and semicolons. Infix arithmetic with mandatory full parenthesization.

```javascript
#lang curly

// constants
define pi 3.14;

// combiners with lambda
define double lambda (x) { (x * 2) };

// combiners with gamma
define sum gamma {
    case (,head . ,(tail)): (head + tail);
    case #nil: 0;
};

// application — space-separated arguments, no commas
sum(list(1 2 3));

// conditional
if (x > 0) { (x + 1) } else { (x - 1) };

// sequencing — braces + semicolons
{
    display("hello");
    display("world");
    42
};

// multi-expression case bodies
define foo gamma {
    case (,x ,y): {
        define z (x + y);
        define w (z * 2);
        w
    };
    case #nil: 0;
};
```

Arguments are space-separated. Comma is reserved for pattern syntax (`,x`, `,(x)`). The expression `f(3 4)` passes the tree `(3 . (4 . #nil))` to `f`.

Infix rule: `(1 + 2)` is valid. `1 + 2 * 3` without parentheses is a **reader error**. The programmer must write `(1 + (2 * 3))` or `((1 + 2) * 3)` explicitly. There is no precedence. The reader translates `(a + b)` to the same tree as round's `(+ a b)`.

Semicolons separate statements. The last expression in a brace block is the return value.

**No anonymous combiners as arguments.** Same rule as round — every `gamma` or `lambda` must be named.

### 3.4 Spacy surface

Spacy uses indentation and colons. Infix arithmetic with mandatory full parenthesization.

```python
#lang spacy

# constants
define pi: 3.14

# combiners with lambda
define double: lambda (x): (x * 2)

# combiners with gamma
define sum: gamma:
    case (,head . ,(tail)): (head + tail)
    case #nil: 0

# application — space-separated arguments
sum(list(1 2 3))

# conditional
if (x > 0):
    (x + 1)
else:
    (x - 1)

# sequencing — newlines under same indentation
define foo: gamma:
    case (,x ,y):
        define z: (x + y)
        define w: (z * 2)
        w
    case #nil: 0
```

The colon is spacy's "here comes the body" marker. It appears after `define name`, after `lambda (params)`, after `gamma`, after `case pattern`, after `if (cond)`, and after `else`.

After a colon in inline position, exactly **one expression** follows as the body. For multi-expression bodies, use a newline and indented block. The last expression in a block is the return value.

Semicolons are permitted as inline statement separators (as in Python) but are discouraged.

**No anonymous combiners as arguments.** Same rule as round and curly. This is the constraint that motivated the universal ban — spacy's indentation-based scoping cannot delimit inline anonymous combiners without ambiguity, so all surfaces share the restriction to maintain equivalence.

The infix rule is the same as curly: mandatory full parenthesization, no precedence, reader translates to prefix trees.

### 3.5 Identifier lexing

The same lexer rule applies to all three surfaces:

- An identifier starts with an alphabetical character or one of `+ - * / < > = ? ! _`.
- It continues until **whitespace** or a **structural delimiter**: `(`, `)`, `{`, `}`, `;`, `:`, `'`, `` ` ``, `"`, `,`.

This means the full Lisp identifier set is available in all surfaces: `list->string`, `ab-cd`, `zero?`, `box!`, `pair-of?` are all single tokens everywhere.

```scheme
;; round
(list->string my-list)
```

```javascript
// curly
list->string(my-list);
```

```python
# spacy
list->string(my-list)
```

The mandatory parenthesization rule (§9.4) ensures infix expressions are unambiguous. Inside `(a op b)`, three space-separated tokens are parsed as infix. Outside of parenthesized infix, identifiers like `ab-cd` are never split — the lexer reads greedily until a delimiter.

```javascript
// curly
(ab-cd + ef-gh)          // infix: three tokens, + is the operator
ab-cd                    // one identifier
map(list->string xs);    // application: two arguments
```

No surface restricts the identifier character set. No underscore translation. No normalization across surfaces.

### 3.6 Argument separation

All three surfaces use **space** as the argument separator. There are no commas between arguments in any surface.

```scheme
;; round
(f 3 4 5)
```

```javascript
// curly
f(3 4 5);
```

```python
# spacy
f(3 4 5)
```

Comma is reserved exclusively for pattern syntax: `,x` (bind), `,(x)` (catamorphism). This is universal across all three surfaces.

### 3.7 Surface equivalence

The following three definitions register the same content hash:

```scheme
;; round
(define add (gamma ((,a ,b) (+ a b))))
```

```javascript
// curly
define add gamma { case (,a ,b): (a + b) };
```

```python
# spacy
define add: gamma:
    case (,a ,b): (a + b)
```

All three surfaces have identical capabilities. Any program written in one surface can be mechanically translated to either of the others. The ban on anonymous combiners as arguments is the constraint that makes this possible.

### 3.8 Comments

**Round:** `;` begins a line comment. `#;` is a datum comment — it comments out the next complete S-expression.

```scheme
(+ 1 #;(ignored) 2)   ;; => 3
```

**Curly:** `//` begins a line comment. `;` is a statement separator and cannot double as a comment marker.

**Spacy:** `#` begins a line comment.

`#;` datum comments are available in all surfaces.

