import Foundation
import AVFoundation

class HuntForKey : Mode {

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
        let randomLetterIndex = Int.random(in: 0 ... letters.count)
        targetKey = String(letters[randomLetterIndex])
        
        say("Press the \(targetKey) key")
    }
    
    func say(_ word: String) {
        let utterance = AVSpeechUtterance(string: word.lowercased())
        synthesizer.speak(utterance)
    }
    
    func immediatelySay(_ word: String) {
        let utterance = AVSpeechUtterance(string: word.lowercased())
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }
    
}
