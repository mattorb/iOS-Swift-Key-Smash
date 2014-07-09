iOS-Swift-Key-Smash
===================

Pair an external bluetooth keyboard to your iOS device, and touch a key to hear the letter name.

Inspired by my 2-year old son who is very interested in "typing" with his palms on our wireless bluetooth keyboard.

notes:
* not hearing speech in simulator, only on device
* mute switch is respected, so make sure device is not muted
* noticeable latency between when key is pressed and spoken.  Tried pre-caching AVSpeechUtterances, and no noticeable improvement there.
