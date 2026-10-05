# API drift from the book's era (GHC 9.10, GHC2024, modern libs)

- scotty: `ScottyT e m a` → `ScottyT m a` (error parameter gone);
  `param` → `pathParam`.
- transformers: `MonadTrans` now has superclass
  `forall m. Monad m => Monad (t m)`; local transformers need
  Functor/Applicative/Monad instances before MonadTrans.
- checkers / Test.QuickCheck.Classes: `traversable` takes an element
  of shape `(f a, g b, c, d)` with `Monoid d`.
- QuickCheck: recursive `Arbitrary` instances must be bounded with
  `sized` or `resize`, otherwise `sequenceA composition` hangs.
- OverloadedStrings makes string literals ambiguous with `elem`;
  annotate with `:: String`.
