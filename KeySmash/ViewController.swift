import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField

    let modeList: [InteractionMode] = [SayPressedKeyMode(), HuntForKeyMode()]
    var currentModeIndex = 0
    var currentMode : InteractionMode { return modeList[currentModeIndex] }

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()    // focus on textField brings up the keyboard
        textField.delegate=self
        
        currentMode.start()
    }
    
    func keyCommands() -> [UIKeyCommand]! {
        return externalKeyboardKeys(Selector("sayKey:"))
    }
    
    func sayKey(command:UIKeyCommand) {
        if(command.input as NSString == UIKeyInputRightArrow)
        {
            nextMode()
        }
        else
        {
            currentMode.respondTo(command.input)
        }
    }
    
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool // return NO to not change text
    {
        return false; // don't actually change the textfield
    }

    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        currentMode.respondTo("enter")
        return false //ignore enter
    }
    
    func nextMode()
    {
        currentModeIndex++
        if(currentModeIndex > modeList.count-1) { currentModeIndex=0; }
        
        currentMode.start()
    }
}

