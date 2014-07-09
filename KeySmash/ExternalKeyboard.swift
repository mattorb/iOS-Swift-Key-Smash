import Foundation
import UIKit

extension UIKeyCommand {
    // allow unnamed params since we re-use this like 20 times in close proximity and the meaning is clear.
    convenience init( _ input: String!, _ modifierFlags: UIKeyModifierFlags, _ action: Selector) {
        self.init(input: input, modifierFlags: modifierFlags, action: action)
    }
}

func externalKeyboardKeys(callback:Selector) -> [UIKeyCommand] {
    var commands = [UIKeyCommand]()
    
    // order matters.  ! needs priority over shift-1, @ over shift-2, etc
    let digits = "!@#$%^&*()~`_+{}|:\"<>?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-=[]\\;',./"
    
    digits.each({
        commands += [UIKeyCommand($0, nil, callback),
                     UIKeyCommand($0, .AlphaShift, callback),
                     UIKeyCommand($0, .Shift, callback),
                     UIKeyCommand($0, .Shift | .AlphaShift, callback)]
    });
    
    // handle some lingering press on ctrl/etc + digit
    digits.each({
        commands += [UIKeyCommand($0, .Command, callback),
                     UIKeyCommand($0, .Control, callback),
                     UIKeyCommand($0, .Alternate, callback)]
    });
    
    commands += [UIKeyCommand(UIKeyInputEscape, nil, callback),
                 UIKeyCommand(UIKeyInputUpArrow, nil, callback),
                 UIKeyCommand(UIKeyInputDownArrow, nil, callback),
                 UIKeyCommand(UIKeyInputLeftArrow, nil, callback),
                 UIKeyCommand(UIKeyInputRightArrow, nil, callback)]
    
    return commands
}
