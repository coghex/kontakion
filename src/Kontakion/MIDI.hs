module Kontakion.MIDI where

import qualified Codec.Midi as Midi
import Codec.ByteString.Parser
import Codec.ByteString.Builder
import Control.Monad

createStartMidi :: IO (Midi.Midi)
createStartMidi = do
  let track0 = [(0,  Midi.NoteOn 0 60 80),
                 (24, Midi.NoteOff 0 60 0),
                 (0,  Midi.TrackEnd)]
      track1 = [(0,  Midi.NoteOn 0 64 80),
                 (24, Midi.NoteOn 0 64 0),
                 (0,  Midi.TrackEnd)]
      midi = Midi.Midi { Midi.fileType = Midi.MultiTrack
                       , Midi.timeDiv  = Midi.TicksPerBeat 24
                       , Midi.tracks   = [track0, track1] }
  -- exportFile "start.mid" midi
  return (midi)
