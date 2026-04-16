## 16. Reader Syntax

The reader converts a character stream into trees. It is not part of the language semantics — it is one possible surface syntax. This section specifies the round (S-expression) reader. The curly and spacy readers (§6.3, §6.4) produce identical trees through different surface conventions.

### 13.1 Atoms

**Integers.** A sequence of digits, optionally preceded by `-` or `+`. Examples: `42`, `-7`, `0`, `+3`. Positive integers may also be written in hexadecimal with the `0x` prefix: `0xFF`, `0xC0FF33`, `0x9f3a7b2c4d5e6f708192a3b4c5d6e7f8`.

**Floats.** Digits with a decimal point, optionally preceded by a sign, optionally followed by an exponent. Examples: `3.14`, `-0.5`, `1e10`, `2.5e-3`.

**Characters.** `#\` followed by a single character or a character name. Examples: `#\a`, `#\Z`, `#\space`, `#\newline`, `#\tab`. The reader recognizes at least `space`, `newline`, `tab`, and `return`.

**Strings.** Delimited by double quotes. Escape sequences: `\\`, `\"`, `\n`, `\t`, `\r`.

### 13.2 Hash-identifiers

A `#` followed by one or more alphanumeric characters or hyphens. Hash-identifiers are identifiers — resolved at registration time like symbols.

Five are pre-defined:

- `#true` — the truthy value.
- `#false` — the sole false value.
- `#nil` — the empty list.
- `#void` — the void singleton, returned by side-effecting operations.
- `#eof` — the end-of-file singleton.

All others are regular identifiers. By convention, a hash-identifier names a singleton.

### 13.3 Symbols (surface syntax only)

An identifier starts with an alphabetical character or one of `+ - * / < > = ? ! _` and continues until whitespace or a structural delimiter: `( ) { } ; : ' `` " ,`. This rule is the same across all three surfaces (§6.5).

Examples: `foo`, `car`, `+`, `list->string`, `point?`, `encapsulation-type`, `ab-cd`, `box!`.

Symbols are surface syntax only. At registration time, they are resolved to content hashes and disappear. They do not exist as runtime values.

### 13.4 Parentheses and pairs

`(a b c)` reads as `(cons a (cons b (cons c #nil)))` — a proper list.

`(a . b)` reads as `(cons a b)` — a pair.

`(a b . c)` reads as `(cons a (cons b c))` — an improper list.

Dot notation in expression position is reader shorthand for `cons`, not a distinct expression form.

### 13.5 Comments

`;` begins a line comment (round surface). `//` begins a line comment (curly surface). `#` begins a line comment (spacy surface).

`#;` is a datum comment in all surfaces — it comments out the next complete expression:

```scheme
(+ 1 #;(ignored) 2)   ;; => 3
```

