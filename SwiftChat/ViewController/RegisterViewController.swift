//
//  RegisterViewController.swift
//  SwiftChat
//
//  Created by Akdag on 27.02.2021.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func registerBtn(_ sender: UIButton) {
        
        if let email = emailText.text ,let password = passwordText.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult , error in
                if let error = error {
                    let ac = UIAlertController(title: A.Alert.tryAgain, message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(ac, animated: true)
                }else{
                    self.performSegue(withIdentifier: A.registerSegue, sender: self)
                }
            }
        }
        
    }
    

}
