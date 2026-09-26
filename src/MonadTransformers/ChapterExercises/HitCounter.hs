{-# LANGUAGE OverloadedStrings #-}

module MonadTransformers.ChapterExercises.HitCounter where

import Control.Monad.Trans.Class
import Control.Monad.Trans.Reader
import Data.IORef
import Data.Map qualified as M
import Data.Maybe (fromMaybe)
import Data.Text.Lazy (Text)
import Data.Text.Lazy qualified as TL
import Network.Wai.Internal
import System.Environment (getArgs)
import Web.Scotty.Trans

data Config
    = Config
    { -- that's one, one click!
      -- two...two clicks!
      -- Three BEAUTIFUL clicks! ah ah ahhhh
      counts :: IORef (M.Map Text Integer)
    , prefix :: Text
    }

-- Stuff inside ScottyT is, except for things that escape
-- via IO, effectively read-only so we can't use StateT.
-- It would overcomplicate things to attempt to do so and
-- you should be using a proper database for production
-- applications.
-- type Scotty = ScottyT Text IO ()
-- type Scotty = ScottyT (ReaderT Config IO) ()

-- type Scotty = ScottyT Text (ReaderT Config IO)
-- type Handler = ActionT Text (ReaderT Config IO)

bumpBoomp ::
    Text ->
    M.Map Text Integer ->
    (M.Map Text Integer, Integer)
bumpBoomp k m = (newM, n)
  where
    n = M.findWithDefault 1 k m
    newM = M.insert k (n + 1) m

updateAndGet :: Text -> Config -> IO Integer
updateAndGet key config = do
    let counter = counts config :: IORef (M.Map Text Integer)
    (m, n) <- bumpBoomp key <$> (readIORef counter :: IO (M.Map Text Integer))
    -- Very important to use writeIORef or something equivalent
    -- otherwise the counter will not be updated
    writeIORef counter m
    return n

app :: Config -> ScottyT IO ()
app config = get "/:key" $ do
    unprefixed <- pathParam "key"
    let p = prefix config
        key' = p <> unprefixed
    newInteger <- liftIO $ updateAndGet key' config
    html $
        mconcat
            [ "<h1>Success! Count was: "
            , TL.pack $ show newInteger
            , "</h1>"
            ]
