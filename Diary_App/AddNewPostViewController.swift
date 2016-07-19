//
//  AddNewPostViewController.swift
//  Diary_App
//
//  Created by Toleen Jaradat on 7/19/16.
//  Copyright © 2016 Toleen Jaradat. All rights reserved.
//

import UIKit

protocol AddingNewPost: class {
    
    func addNewPostDidSave(enteredPost: String)
}


class AddNewPostViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var addPostTextField: UITextField!
    
    weak var addingNewPostdelegate:AddingNewPost!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addPostTextField.delegate = self
    }

    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save(sender: AnyObject) {
        
        let enteredPost = self.addPostTextField.text
        self.addingNewPostdelegate.addNewPostDidSave(enteredPost!)
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    

}
