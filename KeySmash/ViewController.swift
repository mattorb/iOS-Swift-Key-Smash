import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField

    let synthesizer = AVSpeechSynthesizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()    // focus on tf brings up the keyboard
        textField.delegate=self
        
        synthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        speak("Press any key")
    }
    
    func keyCommands() -> [UIKeyCommand]! { // array of UIKeyCommand fails.
        return externalKeyboardKeys()
    }
    
    func sayKey(command:UIKeyCommand) {
        switch (NSString(string:command.input)) // UIKeyConstants are NSStrings
        {
            case UIKeyInputEscape:      speak("escape")
            case UIKeyInputLeftArrow:   speak("left")
            case UIKeyInputRightArrow:  speak("right")
            case UIKeyInputUpArrow:     speak("up")
            case UIKeyInputDownArrow:   speak("down")
            default:                    speak(command.input)
        }
    }
    
    func speak(word:String) {
        let utterance = AVSpeechUtterance(string: word.lowercaseString)
        synthesizer.speakUtterance(utterance)
    }
    
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool // return NO to not change text
    {
        if(string == " ") {
            speak("space")
        }
        
        return false; // don't actually change the textfield
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        speak("enter")
        return false //ignore enter
    }
}

