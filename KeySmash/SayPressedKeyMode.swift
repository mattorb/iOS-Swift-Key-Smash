import Foundation
import UIKit
import AVFoundation

class SayPressedKeyMode : InteractionMode {

    let synthesizer = AVSpeechSynthesizer()

    func start()  {
        say("Press any Key")
    }
    
    func respondTo(key: String) {
        switch (key as NSString) // UIKeyConstants are NSStrings, beta3 needs same type
        {
            case UIKeyInputEscape:      say("escape")
            case UIKeyInputLeftArrow:   say("left")
            case UIKeyInputRightArrow:  say("right")
            case UIKeyInputUpArrow:     say("up")
            case UIKeyInputDownArrow:   say("down")
            case NSString(string:" "):  say("space")
            default:                    say(key)
        }
    }
    
    func say(word: String) {
        let utterance = AVSpeechUtterance(string: word.lowercaseString)
        synthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        synthesizer.speakUtterance(utterance)
    }
}