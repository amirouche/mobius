## 14. Predicates and Typing

Möbius's type discipline is based on predicate calculus rather than object-oriented classification.

Where OOP asks "what IS this value" (identity), Möbius asks "what is TRUE of this value" (predication). The distinction matters:

- A value can satisfy any number of predicates.
- Predicates are ordinary combiners.
- No type must be anticipated at definition time.
- Adding new predicates never requires modifying existing code.

Type inference in Möbius means: given the predicates that hold of a combiner's input, which predicates can be proved to hold of its output?

*The formal inference mechanism is to be specified in a future revision.*

