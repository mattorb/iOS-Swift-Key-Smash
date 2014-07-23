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
        commands += [nil, .AlphaShift, .Shift, .Shift | .AlphaShift].map { UIKeyCommand(digit, $0, callback) }
    }
    
    // handle some lingering press on ctrl/etc + digit
    for digit in digits {
         // two-lines because combining them in beta4 causes compiler crash/stuck
         commands += [.Command, .Control, .Alternate, .Command | .Control, .Command].map { UIKeyCommand(digit, $0, callback) }
         commands += [.Alternate, .Command | .Control | .Alternate, .Control | .Alternate, .Alternate | .Command].map { UIKeyCommand(digit, $0, callback) }
        // two-lines because combining them in beta4 causes compiler crash/stuck
    }
    
    commands += [UIKeyCommand(UIKeyInputEscape, nil, callback),
                 UIKeyCommand(UIKeyInputUpArrow, nil, callback),
                 UIKeyCommand(UIKeyInputDownArrow, nil, callback),
                 UIKeyCommand(UIKeyInputLeftArrow, nil, callback),
                 UIKeyCommand(UIKeyInputRightArrow, nil, callback)]
    
    return commands
}

