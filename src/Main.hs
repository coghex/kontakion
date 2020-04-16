module Main where

import qualified Codec.SoundFont as SF
import qualified Codec.Midi as Midi
import Control.Monad
import Control.Applicative
import Kontakion.MIDI
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
main = do
  midi <- midiNoteTest
  --eMidi <- Midi.importFile "dat/drum.mid"
  --midi <- case eMidi of
  --  Left err -> fail err
  --  Right midi -> return midi
  eSoundFont <- SF.importFile "dat/ultimate_26b_GM.sf2"
  soundFont <- case eSoundFont of
    Left err -> fail err
    Right sf -> return sf
  let paramsGen = soundFontToSynthParams soundFont
      signalFunction = midiToEventSource midi >>> midiSynth paramsGen
  Kontakion.Player.play 11025 (1*1024) 2 signalFunction
  return ()
