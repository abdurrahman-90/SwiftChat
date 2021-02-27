//
//  LoginViewController.swift
//  SwiftChat
//
//  Created by Akdag on 27.02.2021.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func LogInBtn(_ sender: UIButton) {
        
        if let email = emailText.text , let password = passwordText.text {
            Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
                if let error = error{
                    let ac = UIAlertController(title: A.Alert.tryAgain, message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(ac, animated: true)
                }else{
                    self.performSegue(withIdentifier: A.loginSegue, sender: self)
                }
            }
        }
    }
    

}
