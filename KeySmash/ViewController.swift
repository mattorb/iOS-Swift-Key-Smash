import UIKit
import Foundation
import AVFoundation

extension UIKeyCommand {
    // allow unnamed params since we re-use this like 20 times in close proximity and the meaning is clear.
    convenience init( _ input: String!, _ modifierFlags: UIKeyModifierFlags, _ action: Selector) {
        self.init(input: input, modifierFlags: modifierFlags, action: action)
    }
}

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField

    let synthesizer = AVSpeechSynthesizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        textField.delegate=self
        
        synthesizer.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
    }
    
    func keyCommands() -> [AnyObject]! {
        
        var commands = [UIKeyCommand]()
        
        // order matters.  ! needs priority over shift-1, @ over shift-2, etc
        let digits = "!@#$%^&*()~`_+{}|:\"<>?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-=[]\\;',./"

        for digit in digits
        {
            let sdigit = String(digit)
            commands += [UIKeyCommand(sdigit, nil, "sayKey:"),
                         UIKeyCommand(sdigit, .AlphaShift, "sayKey:"),
                         UIKeyCommand(sdigit, .Shift, "sayKey:"),
                         UIKeyCommand(sdigit, UIKeyModifierFlags.Shift|UIKeyModifierFlags.AlphaShift, "sayKey:")]
        }

        for digit in digits
        {
            let sdigit = String(digit)

            // handle some resting/smashy palms/fingers in combination with normal keys
            commands += [UIKeyCommand(sdigit, .Command, "sayKey:"),
                         UIKeyCommand(sdigit, .Control, "sayKey:"),
                         UIKeyCommand(sdigit, .Alternate, "sayKey:")]
        }
        
        commands += [UIKeyCommand(UIKeyInputEscape, nil, "sayKey:"),
                     UIKeyCommand(UIKeyInputUpArrow, nil, "sayKey:"),
                     UIKeyCommand(UIKeyInputDownArrow, nil, "sayKey:"),
                     UIKeyCommand(UIKeyInputLeftArrow, nil, "sayKey:"),
                     UIKeyCommand(UIKeyInputRightArrow, nil, "sayKey:")]
        
        return commands
    }
    
    func sayKey(command:UIKeyCommand) {
        switch (command.input)
        {
            //hmph. no ~= operator (needed for case test) for String to NSString?
            case String(UIKeyInputEscape):speak("escape")
            case String(UIKeyInputLeftArrow):speak("left")
            case String(UIKeyInputRightArrow):speak("right")
            case String(UIKeyInputUpArrow):speak("up")
            case String(UIKeyInputDownArrow):speak("down")
            default: speak(command.input)
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

