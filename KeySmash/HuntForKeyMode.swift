import Foundation
import AVFoundation

class HuntForKeyMode : InteractionMode {

    let letters = Array("abcdefghijklmnopqrstuvwxyz")

    let synthesizer = AVSpeechSynthesizer()

    var targetKey = ""
    
    init() {
        synthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
    }
    
    func start()  {
        randomizeKey()
    }
    
    func respondTo(key: String)  {
        if(key == targetKey)
        {
            say("Great job! You pressed the letter \(targetKey)")
            
            randomizeKey()
        }
        else
        {
            say("No.  Try again.")
        }
    }
    
    func randomizeKey () {
        let randomLetterIndex = random() % letters.count
        targetKey = String(letters[randomLetterIndex])
        
        say("Press the \(targetKey) key")
    }
    
    func say(word: String) {
        let utterance = AVSpeechUtterance(string: word.lowercaseString)
        synthesizer.speakUtterance(utterance)
    }
}