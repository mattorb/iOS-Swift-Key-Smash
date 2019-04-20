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
            case UIKeyCommand.inputEscape:      say("escape")
            case UIKeyCommand.inputLeftArrow:   say("left")
            case UIKeyCommand.inputRightArrow:  say("right")
            case UIKeyCommand.inputUpArrow:     say("up")
            case UIKeyCommand.inputDownArrow:   say("down")
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
