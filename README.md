![live demo](https://raw.githubusercontent.com/mattorb/iOS-Swift-Key-Smash/gh-pages/keysmashlive.gif)
    
iOS-Swift-Key-Smash
===================

Inspired by my 2-year old son who is very interested in my wireless bluetooth keyboard.

Pair an external bluetooth keyboard to your iOS device.

Press the right arrow key to select a mode.

Available modes

1.  Press a key and hear it said.
2.  Hunt for and press a key that is spoken aloud.
3.  Type the abc's in order.
4.  Count 

notes

* not hearing speech in simulator, only on device
* mute switch is respected, so make sure device is not muted
* noticeable latency between when key is pressed and spoken.  Tried pre-caching AVSpeechUtterances, and no noticeable improvement there.
