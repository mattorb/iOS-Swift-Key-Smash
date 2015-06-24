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
    let noModifiers = UIKeyModifierFlags(rawValue: 0)

    // order matters.  ! needs priority over shift-1, @ over shift-2, etc
    let digits = "!@#$%^&*()~`_+{}|:\"<>?abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-=[]\\;',./ "
    
    for digit in digits.characters {
        commands += [noModifiers, .AlphaShift, .Shift, [UIKeyModifierFlags.AlphaShift, UIKeyModifierFlags.Shift]].map { UIKeyCommand(digit, $0, callback) }
    }
    
    // handle some lingering press on ctrl/alt/command + digit
    for digit in digits.characters {
        let generateKeyCommands = { UIKeyCommand(digit, $0, callback) }
        
         // four-lines because combining them all in Swift2 (XC 7b2) causes compiler error "expression too complex"
         commands += [.Command, .Control, .Alternate].map(generateKeyCommands)
         commands += [[.Command, .Control], [.Command, .Alternate]].map(generateKeyCommands)
         commands += [[.Command, .Control, .Alternate]].map(generateKeyCommands)
         commands += [[.Control, .Alternate], [.Alternate, .Command]].map(generateKeyCommands)
    }
    
    commands += [UIKeyCommand(UIKeyInputEscape, noModifiers, callback),
                 UIKeyCommand(UIKeyInputUpArrow, noModifiers, callback),
                 UIKeyCommand(UIKeyInputDownArrow, noModifiers, callback),
                 UIKeyCommand(UIKeyInputLeftArrow, noModifiers, callback),
                 UIKeyCommand(UIKeyInputRightArrow, noModifiers, callback)]
    
    return commands
}

