import Foundation
import AVFoundation

class Counting : Mode
{
    let synthesizer = AVSpeechSynthesizer()
    
    let numbers = Array("123456789")
    var numberIndex = -1
    
    var targetKey : String { return String(numbers[numberIndex]) }
    
    func start()  {
        say("Can you count from 1 to 9?")
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
        numberIndex+=1
        
        if(numberIndex > numbers.count-1) {
            numberIndex = 0;
            say("Great Job!  You counted to 9.   Let's do it again!")
        }
        
        say("Press \(targetKey)")
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
