module Main where
import Control.Monad
import Sound.ALUT

main :: IO ()
main = withProgNameAndArgs runALUT $ \_progName _args -> do
  helloBuffer <- createBuffer $ Sine 440 0 1
  helloSource <- genObjectName
  buffer helloSource $= Just helloBuffer
  play [helloSource]
  sleep 1
