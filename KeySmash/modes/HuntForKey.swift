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
    
    private func randomizeKey () {
        targetKey = String(letters.randomElement()!)
        
        say("Press the \(targetKey) key")
    }
    
    private func say(_ word: String) {
        let utterance = AVSpeechUtterance(string: word.lowercased())
        synthesizer.speak(utterance)
    }
    
    private func immediatelySay(_ word: String) {
        let utterance = AVSpeechUtterance(string: word.lowercased())
        synthesizer.stopSpeaking(at: .immediate)
        synthesizer.speak(utterance)
    }
    
}
