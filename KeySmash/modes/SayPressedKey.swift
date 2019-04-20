import Foundation
import UIKit
import AVFoundation

class SayPressedKey : Mode {

    let synthesizer = AVSpeechSynthesizer()

    func start()  {
        say("Press any Key")
    }
    
    func respondTo(key: String) {
        switch (key) // UIKeyConstants are NSStrings, beta3 needs same type
        {
            case UIKeyInputEscape:      say("escape")
            case UIKeyInputLeftArrow:   say("left")
            case UIKeyInputRightArrow:  say("right")
            case UIKeyInputUpArrow:     say("up")
            case UIKeyInputDownArrow:   say("down")
            case " ":                   say("space")
            default:                    say(key)
        }
    }
    
    func say(_ word: String) {
        let utterance = AVSpeechUtterance(string: word.lowercased())
        synthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
        synthesizer.speak(utterance)
    }
}
