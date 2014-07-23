import Foundation
import UIKit

extension UIKeyCommand {
    // allow unnamed params since we re-use this like 20 times in close proximity and the meaning is clear.
    
    convenience init( _ input: Character!, _ modifierFlags: UIKeyModifierFlags, _ action: Selector) {
        self.init(input: String(input), modifierFlags: modifierFlags, action: action)
    }
    
    convenience init( _ input: String!, _ modifierFlags: UIKeyModifierFlags, _ action: Selector) {
        self.init(input: input, modifierFlags: modifierFlags, action: action)
    }
}

func externalKeyboardKeys(callback:Selector) -> [UIKeyCommand] {
    var commands = [UIKeyCommand]()
    
    // order matters.  ! needs priority over shift-1, @ over shift-2, etc
    let digits = "!@#$%^&*()~`_+{}|:\"<>?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-=[]\\;',./ "
    
    for digit in digits {
        commands += [
            UIKeyCommand(digit, nil, callback),
            UIKeyCommand(digit, .AlphaShift, callback),
            UIKeyCommand(digit, .Shift, callback),
            UIKeyCommand(digit, .Shift | .AlphaShift, callback)]
    }
    
    // handle some lingering press on ctrl/etc + digit
    for digit in digits {
        commands += [UIKeyCommand(digit, .Command, callback),
                     UIKeyCommand(digit, .Control, callback),
                     UIKeyCommand(digit, .Alternate, callback)]
    }
    
    commands += [UIKeyCommand(UIKeyInputEscape, nil, callback),
                 UIKeyCommand(UIKeyInputUpArrow, nil, callback),
                 UIKeyCommand(UIKeyInputDownArrow, nil, callback),
                 UIKeyCommand(UIKeyInputLeftArrow, nil, callback),
                 UIKeyCommand(UIKeyInputRightArrow, nil, callback)]
    
    return commands
}
