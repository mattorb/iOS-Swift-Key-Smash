import Foundation
import UIKit
import AVFoundation

class SayPressedKeyMode : InteractionMode {

    let synthesizer = AVSpeechSynthesizer()

    init() {
        synthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
    }

    func start()  {
        say("Press any Key")
    }
    
    func respondTo(key: String) {
        switch (NSString(string:key)) // UIKeyConstants are NSStrings, beta3 needs same type
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
        synthesizer.speakUtterance(utterance)
    }
}