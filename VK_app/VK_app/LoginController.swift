//
//  ViewController.swift
//  VK_app
//
//  Created by Aleksandr Fetisov on 28/06/2019.
//  Copyright © 2019 Aleksandr Fetisov. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    @IBAction func LogInButtonPressed(_ sender: Any) {
        print("username: \(usernameTextField.text ?? "")")
        print("password: \(passwordTextField.text ?? "")")
    }
}
