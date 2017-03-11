{-# LANGUAGE GADTs, KindSignatures #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE UndecidableInstances #-}

import Control.Monad
import Control.Applicative

-- Reverse apply
(-:) :: a -> (a -> b) -> b
(-:) = flip id

infixl 1 -:

