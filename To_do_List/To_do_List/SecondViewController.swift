//
//  SecondViewController.swift
//  To_do_List
//
//  Created by Alexandre Henrique Silva on 09/03/18.
//  Copyright © 2018 Alexhenri. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var toDoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addButton.layer.cornerRadius = 8
    }
    
    // close keyboard when any where outside the textfield is pressed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // close keyboard when return button is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        
        toDoTextField.resignFirstResponder()
        
        // call function to actually add to list
        if addToList() {
            
            resultLabel.text        = "Successfully added to your list."
            resultLabel.textColor   = UIColor(red: 0.0392, green: 0.5882, blue: 0, alpha: 1.0)
            
        } else {
            resultLabel.text        = "Sorry, but an error occurred. Please try it again."
            resultLabel.textColor   = UIColor(red: 0.7373, green: 0, blue: 0, alpha: 1.0) /* #bc0000 */
            
        }
        
        toDoTextField.text = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // change 2 to desired number of seconds
            // Your code with delay
            self.resultLabel.text   = ""
        }
        
    }
    
    func addToList() -> Bool {
        
        // if for any reason cannot gets the textfield content return false
        guard let toDo = toDoTextField.text else {
            print("Error \(#line): Cannot access the textField content")
            return false
        }
        
        guard toDo != "" else {
            print("Error \(#line): Textfield is blank")
            return false
        }
        
        // call function to add to list in user default array
        return addToUserDefaultList(toDo: toDo)
    }
    
    func addToUserDefaultList(toDo: String) -> Bool{
        
        guard let arrayListObject = UserDefaults.standard.object(forKey: "arrayList") else {
            print("Error \(#line): Cannot access the user default array list")
            return false
        }
    
        guard var arrayList = arrayListObject as? Array<String> else {
            print("Error \(#line): Cannot identify the array list as a string array")
            return false
        }
        
        arrayList.append(toDo)
        UserDefaults.standard.set(arrayList, forKey: "arrayList")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)

        return true
    }

}

