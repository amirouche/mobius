## 26. Checks

A check is a combiner that takes one argument — the combiner under test — and verifies properties of it using `assume`. Checks are the specification language of Möbius: a well-written check suite is a problem statement.

**Round:**
```scheme
(define ~check-gcd-base-cases
  (lambda (gcd)
    (begin
      (assume (= 6 (gcd 6 0)) "gcd(6,0) should be 6")
      (assume (= 7 (gcd 0 7)) "gcd(0,7) should be 7")
      (assume (= 1 (gcd 1 1)) "gcd(1,1) should be 1"))))

(define ~check-gcd-commutative
  (lambda (gcd)
    (begin
      (assume (= (gcd 48 18) (gcd 18 48)) "gcd must be commutative")
      (assume (= (gcd 100 75) (gcd 75 100)) "gcd must be commutative"))))
```

**Curly:**
```javascript
define ~check-gcd-base-cases lambda (gcd) {
    assume((gcd(6 0) = 6) "gcd(6,0) should be 6");
    assume((gcd(0 7) = 7) "gcd(0,7) should be 7");
    assume((gcd(1 1) = 1) "gcd(1,1) should be 1");
};
```

**Spacy:**
```python
define ~check-gcd-base-cases: lambda (gcd):
    assume((gcd(6 0) = 6) "gcd(6,0) should be 6")
    assume((gcd(0 7) = 7) "gcd(0,7) should be 7")
    assume((gcd(1 1) = 1) "gcd(1,1) should be 1")
```

**Why lambda, not gamma.** A check takes one argument — the candidate combiner — and names it. There is no dispatch on shape. Lambda is the right tool: one parameter, one name, the parameter name documents what the check expects.

**Why the combiner under test is an argument, not a name.** The check receives the candidate as a value, not as a name bound in the environment. This makes checks portable: the same check can verify any combiner that claims to satisfy the specification, in any store, under any name, in any language. The check's hash depends only on what it tests, not on who it tests.

**Naming convention.** Check names begin with `~check-`. This is a convention enforced by the `bb` toolchain, not a language rule. The `~` prefix prevents collision with ordinary combiners and signals to `bb add` that the combiner is a check, not content.

**Check execution.** `bb check` applies each check combiner to the combiner under test:

```
(~check-gcd-base-cases gcd)
```

If every `assume` passes, the check passes. If any `assume` fails, the check fails and reports which assertion failed. `bb check` runs all checks associated with a combiner and reports results.

**Checks are content-addressed.** Each check is a combiner in the store with its own hash, its own mappings, its own lineage. A check can be forked, translated, reviewed, and curated like any other combiner. The association between a combiner and its checks is recorded in the combiner's lineage — the check hashes are listed there, not embedded in the combiner's tree.

**Checks and ZKPs.** Because a check takes the combiner under test as an argument, the ZKP statement is clean: "there exists a tree T such that `sha256(serialize(T)) = H` and `check(T)` passes." One application, no environment setup, no name resolution in the proof circuit.


