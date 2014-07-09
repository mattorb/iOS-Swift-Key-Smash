import Foundation
import UIKit

extension UIKeyCommand {
    // allow unnamed params since we re-use this like 20 times in close proximity and the meaning is clear.
    convenience init( _ input: String!, _ modifierFlags: UIKeyModifierFlags, _ action: Selector) {
        self.init(input: input, modifierFlags: modifierFlags, action: action)
    }
}

func externalKeyboardKeys() -> [UIKeyCommand] {
    var commands = [UIKeyCommand]()
    
    // order matters.  ! needs priority over shift-1, @ over shift-2, etc
    let digits = "!@#$%^&*()~`_+{}|:\"<>?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-=[]\\;',./"
    
    digits.each({
        commands += [UIKeyCommand($0, nil, "sayKey:"),
                     UIKeyCommand($0, .AlphaShift, "sayKey:"),
                     UIKeyCommand($0, .Shift, "sayKey:"),
                     UIKeyCommand($0, .Shift | .AlphaShift, "sayKey:")]
        });
    
    // handle some lingering press on ctrl/etc + digit
    digits.each({
        commands += [UIKeyCommand($0, .Command, "sayKey:"),
                     UIKeyCommand($0, .Control, "sayKey:"),
                     UIKeyCommand($0, .Alternate, "sayKey:")]
        });
    
    commands += [UIKeyCommand(UIKeyInputEscape, nil, "sayKey:"),
                 UIKeyCommand(UIKeyInputUpArrow, nil, "sayKey:"),
                 UIKeyCommand(UIKeyInputDownArrow, nil, "sayKey:"),
                 UIKeyCommand(UIKeyInputLeftArrow, nil, "sayKey:"),
                 UIKeyCommand(UIKeyInputRightArrow, nil, "sayKey:")]
    
    return commands
}
