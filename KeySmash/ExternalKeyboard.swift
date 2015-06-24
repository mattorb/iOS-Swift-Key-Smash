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
        commands += [noModifiers, .AlphaShift, .Shift, [.AlphaShift, .Shift]].map { UIKeyCommand(digit, $0, callback) }
    }
    
    // handle some lingering press on ctrl/alt/command + digit
    for digit in digits.characters {
        let modifiers:Array<UIKeyModifierFlags> = [.Command,
                                                   .Control,
                                                   .Alternate,
                                                   [.Command, .Control], //not an array, single optionset, command+control
                                                   [.Command, .Alternate],
                                                   [.Command, .Control, .Alternate],
                                                   [.Control, .Alternate]
                                                  ]
        
        commands += modifiers.map { UIKeyCommand(digit, $0, callback) }
    }
    
    commands += [UIKeyCommand(UIKeyInputEscape, noModifiers, callback),
                 UIKeyCommand(UIKeyInputUpArrow, noModifiers, callback),
                 UIKeyCommand(UIKeyInputDownArrow, noModifiers, callback),
                 UIKeyCommand(UIKeyInputLeftArrow, noModifiers, callback),
                 UIKeyCommand(UIKeyInputRightArrow, noModifiers, callback)]
    
    return commands
}

