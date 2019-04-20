import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!

    let modeList: [Mode] = [SayPressedKey(), HuntForKey(), OrderedAlphabet(), Counting()]
    var currentModeIndex = 0
    var currentMode : Mode { return modeList[currentModeIndex] }
    let keyCommandCache = externalKeyboardKeys(callback: #selector(sayKey))

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()    // focus on textField brings up the keyboard
        textField.delegate=self
        
        currentMode.start()
    }
    
    override var keyCommands: [UIKeyCommand]? {
        get {
            return keyCommandCache
        }
    }
    
    func sayKey(command:UIKeyCommand) {
        if(command.input == UIKeyInputRightArrow)
        {
            nextMode()
        }
        else
        {
            currentMode.respondTo(key: command.input)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool // return NO to not change text
    {
        return false; // don't actually change the textfield
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        currentMode.respondTo(key: "enter")
        return false //ignore enter
    }
    
    func nextMode()
    {
        currentModeIndex+=1
        if(currentModeIndex > modeList.count-1) { currentModeIndex=0; }
        
        currentMode.start()
    }
}

