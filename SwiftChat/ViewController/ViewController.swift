//
//  ViewController.swift
//  SwiftChat
//
//  Created by Akdag on 27.02.2021.
//

import UIKit
import CLTypingLabel

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: CLTypingLabel!
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
    }


}

