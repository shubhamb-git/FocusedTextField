//
//  ViewController.swift
//  Focused Textfield
//
//  Created by Shubh on 02/08/18.
//  Copyright © 2018 Shubh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldEmail: FocusedTextField!
    @IBOutlet weak var textFieldPassword: FocusedTextField!
    @IBOutlet weak var buttonLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.buttonLogin.layer.cornerRadius = self.buttonLogin.bounds.height/2
    }
    
    @IBAction func loginButtonTapped() {
        self.textFieldEmail.resignFirstResponder()
        self.textFieldPassword.resignFirstResponder()
    }
}

extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == textFieldEmail {
            self.textFieldPassword.becomeFirstResponder()
        } else {
            self.textFieldPassword.resignFirstResponder()
        }
        return true
    }
}
