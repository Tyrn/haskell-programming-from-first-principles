module MonadTransformers.MonadTrans.Exercises where

import Control.Applicative (liftA2)
import Control.Monad.Trans.Class

-- | A minimal Either transformer.
newtype EitherT e m a = EitherT {runEitherT :: m (Either e a)}

instance (Functor m) => Functor (EitherT e m) where
    fmap f (EitherT m) = EitherT (fmap (fmap f) m)

instance (Applicative m) => Applicative (EitherT e m) where
    pure = EitherT . pure . Right
    EitherT mf <*> EitherT ma = EitherT $ liftA2 (<*>) mf ma

instance (Monad m) => Monad (EitherT e m) where
    EitherT m >>= f = EitherT $ do
        e <- m
        case e of
            Left e -> pure (Left e)
            Right a -> runEitherT (f a)

instance MonadTrans (EitherT e) where
    lift = EitherT . fmap Right

-- | A minimal State transformer.
newtype StateT s m a = StateT {runStateT :: s -> m (a, s)}

instance (Functor m) => Functor (StateT s m) where
    fmap f (StateT g) = StateT $ \s -> fmap (\(a, s') -> (f a, s')) (g s)

instance (Monad m) => Applicative (StateT s m) where
    pure a = StateT $ \s -> pure (a, s)
    StateT mf <*> StateT ma = StateT $ \s -> do
        (f, s') <- mf s
        (a, s'') <- ma s'
        pure (f a, s'')

instance (Monad m) => Monad (StateT s m) where
    StateT m >>= f = StateT $ \s -> do
        (a, s') <- m s
        runStateT (f a) s'

instance MonadTrans (StateT s) where
    lift ma = StateT $ \s -> do
        a <- ma
        pure (a, s)
