module Main where

import qualified Codec.SoundFont as SF
import qualified Codec.Midi as Midi
import Control.Monad
import Control.Applicative
import qualified Sound.ALUT as ALUT
import Kontakion.Player
import Kontakion.SynthParams
import Kontakion.Synth
import FRP.Yampa
import System.IO

data Flag = SampleRate String
          | SountFontFile FilePath
          | MidiFile FilePath
          deriving Show

main :: IO ()
main = do--ALUT.withProgNameAndArgs ALUT.runALUT $ \_progName _args -> do
  --helloBuffer <- ALUT.createBuffer $ ALUT.Sine 440 0 1
  --helloSource <- ALUT.genObjectName
  --ALUT.buffer helloSource ALUT.$= Just helloBuffer
  --ALUT.play [helloSource]
  --ALUT.sleep 1

  hPutStrLn stderr "Importing MIDI File ..."
  eMidi <- Midi.importFile "dat/guitars.mid"
  midi <- case eMidi of
    Left err -> fail err
    Right midi -> return midi
  hPutStrLn stderr "done"
  hPutStrLn stderr "Importing SF File ..."
  eSoundFont <- SF.importFile "dat/ultimate_26b_GM.sf2"
  soundFont <- case eSoundFont of
    Left err -> fail err
    Right sf -> return sf
  hPutStrLn stderr "done"
  let paramsGen = soundFontToSynthParams soundFont
      signalFunction = midiToEventSource midi >>> midiSynth paramsGen
  Kontakion.Player.play 44100 (1*1024) 2 signalFunction
