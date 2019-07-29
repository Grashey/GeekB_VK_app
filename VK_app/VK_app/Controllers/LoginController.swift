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
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet weak var dotFirst: LoadingDotView!
    @IBOutlet weak var dotSecond: LoadingDotView!
    @IBOutlet weak var dotThird: LoadingDotView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dotFirst.backgroundColor = .clear
        dotFirst.alpha = 0
        dotSecond.backgroundColor = .clear
        dotSecond.alpha = 0
        dotThird.backgroundColor = .clear
        dotThird.alpha = 0
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGR.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(tapGR)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadingDots()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
        
        navigationController?.navigationBar.isHidden = false
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    @IBAction func LogInButtonPressed(_ sender: Any) {
        
        print("username: \(usernameTextField.text ?? "")")
        print("password: \(passwordTextField.text ?? "")")
    }
    
    @objc private func keyboardWasShown(notification: Notification){
        let info = notification.userInfo as NSDictionary?
        let keyboardSize = (info?.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 10, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWasHidden(notification: Notification){
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func hideKeyboard(){
        self.scrollView.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "LoginSegue"
            //usernameTextField.text == "admin",
            //passwordTextField.text == "123456"
        {
            return true
        } else {
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "LoginSegue"{
            self.passwordTextField.text = ""
        }
    }
    
    private func loadingDots() {
        UIView.animate(withDuration: 0.7, delay: 0, options: [.autoreverse, .repeat], animations: {
            self.dotFirst.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.7, delay: 0.2, options: [.autoreverse, .repeat], animations: {
            self.dotSecond.alpha = 1
        }, completion: nil)
        UIView.animate(withDuration: 0.7, delay: 0.5, options: [.autoreverse, .repeat], animations: {
            self.dotThird.alpha = 1
        }, completion: nil)
    }
    
}
