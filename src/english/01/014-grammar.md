## 18. Grammar

### 15.1 Round surface grammar

```bnf
program     ::= expression*

expression  ::= atom
              | identifier
              | (gamma clause+)
              | (if expression expression expression)
              | (begin expression+)
              | (define identifier expression)
              | (guard guard-body)
              | (lambda formals expression)        ;; foundation
              | (and expression+)                  ;; foundation
              | (or expression+)                   ;; foundation
              | (expression expression*)
              
clause      ::= (pattern expression)

guard-body  ::= (entry clause*) (exit clause*) expression

formals     ::= (identifier*)

pattern     ::= atom                       ;; literal gamma
              | ,identifier                ;; bind
              | ,(identifier)              ;; recurse-and-bind
              | ,_                         ;; wildcard
              | (? identifier ,identifier) ;; predicate guard
              | (pattern . pattern)        ;; pair
              | (pattern*)                 ;; list (shorthand for nested pairs)

atom        ::= integer | float | character | string

integer     ::= [+-]? digit+
              |  '0x' hex-digit+
float       ::= [+-]? digit+ '.' digit* ([eE] [+-]? digit+)?
character   ::= '#\' (character-name | any-character)
string      ::= '"' string-char* '"'

identifier  ::= symbol | hash-id
symbol      ::= id-start id-continue*
id-start    ::= alpha | '+' | '-' | '*' | '/' | '<' | '>' | '=' | '?' | '!' | '_'
id-continue ::= (any character except whitespace and delimiters: ( ) { } ; : ' ` " ,)
hash-id     ::= '#' (alpha | digit | '-')+
```

### 15.2 Curly surface grammar

```bnf
program     ::= statement*

statement   ::= define-stmt | expression ';'

define-stmt ::= 'define' identifier expression ';'
              | 'define' identifier gamma-expr ';'
              | 'define' identifier lambda-expr ';'

expression  ::= atom
              | identifier
              | gamma-expr
              | lambda-expr
              | guard-expr
              | identifier '(' args ')'           ;; application
              | '(' expression op expression ')'  ;; infix
              | 'if' '(' expression ')' block
                ('else' block)?
              | '{' statement* expression '}'      ;; begin block

gamma-expr  ::= 'gamma' '{' case-clause+ '}'

case-clause ::= 'case' pattern ':' expression ';'
              | 'case' pattern ':' block ';'

lambda-expr ::= 'lambda' '(' identifier* ')' block

guard-expr  ::= 'guard' '{'
                  'entry' ':' case-clause*
                  'exit' ':' case-clause*
                  'body' ':' expression ';'
                '}'

block       ::= '{' statement* expression '}'

args        ::= expression*

op          ::= '+' | '-' | '*' | '/' | '<' | '>' | '='
              | identifier                        ;; any combiner as infix

pattern     ::= (same as round — §15.1)
```

### 15.3 Spacy surface grammar

```bnf
program     ::= line*

line        ::= define-line | expression

define-line ::= 'define' identifier ':' expression
              | 'define' identifier ':' gamma-block
              | 'define' identifier ':' lambda-line

expression  ::= atom
              | identifier
              | identifier '(' args ')'           ;; application
              | '(' expression op expression ')'  ;; infix
              | if-expr

gamma-block ::= 'gamma' ':' INDENT case-line+ DEDENT

case-line   ::= 'case' pattern ':' expression
              | 'case' pattern ':' INDENT line+ DEDENT

lambda-line ::= 'lambda' '(' identifier* ')' ':' expression

guard-block ::= 'guard' ':' INDENT
                  'entry' ':' INDENT case-line* DEDENT
                  'exit' ':' INDENT case-line* DEDENT
                  'body' ':' expression
                DEDENT

if-expr     ::= 'if' '(' expression ')' ':' INDENT
                  line+ DEDENT
                'else' ':' INDENT line+ DEDENT

args        ::= expression*

op          ::= (same as curly — §15.2)

pattern     ::= (same as round — §15.1)

INDENT      ::= (increase in indentation level)
DEDENT      ::= (decrease in indentation level)
```

Note: anonymous lambda/gamma as arguments is not supported in any surface. Use a named `define` instead.


---

