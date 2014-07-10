import Foundation
import AVFoundation

class HuntForKeyMode : InteractionMode {

    let synthesizer = AVSpeechSynthesizer()

    
    let letters = Array("abcdefghijklmnopqrstuvwxyz")
    var targetKey = ""
    
    func start()  {
        randomizeKey()
    }
    
    func respondTo(key: String)  {
        if(key == targetKey)
        {
            immediatelySay("Great job! You pressed the letter \(targetKey)")
            
            randomizeKey()
        }
        else
        {
            immediatelySay("No.  Try again.  Press the \(targetKey) key")
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
    
    func immediatelySay(word: String) {
        let utterance = AVSpeechUtterance(string: word.lowercaseString)
        synthesizer.stopSpeakingAtBoundary(.Immediate)
        synthesizer.speakUtterance(utterance)
    }
    
}