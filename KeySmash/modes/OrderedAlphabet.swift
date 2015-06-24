import Foundation
import AVFoundation

class OrderedAlphabet : Mode
{
    let synthesizer = AVSpeechSynthesizer()
    
    let letters = Array("abcdefghijklmnopqrstuvwxyz".characters)
    var letterIndex = -1

    var targetKey : String { return String(letters[letterIndex]) }
    
    func start()  {
        say("Can you type your a b c's?")
        nextKey()
    }
    
    func respondTo(key: String)  {
        if(key == targetKey)
        {
            immediatelySay("\(targetKey)")
            
            nextKey()
        }
        else
        {
            immediatelySay("No.  Try again.  Press the \(targetKey) key")
        }
    }
    
    func nextKey () {
        letterIndex++
        
        if(letterIndex > letters.count-1) {
            letterIndex = 0;
            say("Great Job!  You typed the a b c's .   Let's do it again!")
        }
        
        say("Type \(targetKey)")
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