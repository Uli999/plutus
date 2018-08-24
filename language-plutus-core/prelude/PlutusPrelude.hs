module PlutusPrelude ( -- * Reëxports from base
                       (&&&)
                     , toList
                     , bool
                     , first
                     , second
                     , on
                     , isJust
                     , guard
                     , foldl'
                     , fold
                     , throw
                     , join
                     , (<=<)
                     , fromRight
                     , Generic
                     , NFData
                     , Natural
                     , NonEmpty (..)
                     , Pretty (..)
                     , Word8
                     , Semigroup (..)
                     , Alternative (..)
                     , Exception
                     , PairT (..)
                     , Typeable
                     -- * Reëxports from "Control.Composition"
                     , (.*)
                     -- * Custom functions
                     , prettyString
                     , render
                     , repeatM
                     , (?)
                     -- Reëxports from "Data.Text.Prettyprint.Doc"
                     , (<+>)
                     , parens
                     , braces
                     , brackets
                     , squotes
                     , list
                     , Doc
                     ) where

import           Control.Applicative                     (Alternative (..))
import           Control.Arrow                           ((&&&))
import           Control.Composition                     ((.*))
import           Control.DeepSeq                         (NFData)
import           Control.Exception                       (Exception, throw)
import           Control.Monad                           (guard, join, (<=<))
import           Data.Bifunctor                          (first, second)
import           Data.Bool                               (bool)
import           Data.Either                             (fromRight)
import           Data.Foldable                           (fold, toList)
import           Data.Function                           (on)
import           Data.List                               (foldl')
import           Data.List.NonEmpty                      (NonEmpty (..))
import           Data.Maybe                              (isJust)
import           Data.Semigroup
import qualified Data.Text                               as T
import           Data.Text.Prettyprint.Doc
import           Data.Text.Prettyprint.Doc.Render.String (renderString)
import           Data.Text.Prettyprint.Doc.Render.Text   (renderStrict)
import           Data.Typeable                           (Typeable)
import           Data.Word                               (Word8)
import           GHC.Generics                            (Generic)
import           GHC.Natural                             (Natural)

infixr 2 ?

render :: Doc a -> T.Text
render = renderStrict . layoutSmart defaultLayoutOptions

-- | Make sure your 'Applicative' is sufficiently lazy!
repeatM :: Applicative f => f a -> f [a]
repeatM x = (:) <$> x <*> repeatM x

newtype PairT b f a = PairT
    { unPairT :: f (b, a)
    }

instance Functor f => Functor (PairT b f) where
    fmap f (PairT p) = PairT $ fmap (fmap f) p

(?) :: Alternative f => Bool -> a -> f a
(?) b x = x <$ guard b

prettyString :: Pretty a => a -> String
prettyString = renderString . layoutPretty defaultLayoutOptions . pretty
