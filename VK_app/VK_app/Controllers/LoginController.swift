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
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var loginTitleView: UILabel!
    @IBOutlet weak var passwordTitleView: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet weak var dotFirst: LoadingDotView!
    @IBOutlet weak var dotSecond: LoadingDotView!
    @IBOutlet weak var dotThird: LoadingDotView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dotFirst.backgroundColor = .clear
        dotSecond.backgroundColor = .clear
        dotThird.backgroundColor = .clear
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGR.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(tapGR)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.animateTitlesAppearing()
        self.animateTitleAppearing()
        self.animateFieldsAppearing()
        self.animateAuthButton()
        
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
    // MARK: - Animations
    private func loadingDots() {
        UIView.animate(withDuration: 0.7, delay: 0, options: .autoreverse, animations: {
            self.dotFirst.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: 0.7, delay: 0.2, options: .autoreverse, animations: {
            self.dotSecond.alpha = 0
        }, completion: nil)
        UIView.animate(withDuration: 0.7, delay: 0.5, options: .autoreverse, animations: {
            self.dotThird.alpha = 0
        }, completion: nil)
    }
    
    private func animateTitlesAppearing() {
        let offset = view.bounds.width
        loginTitleView.transform = CGAffineTransform(translationX: -offset, y: 0)
        passwordTitleView.transform = CGAffineTransform(translationX: -offset, y: 0)
        
        UIView.animate(withDuration: 1, delay: 1, options: .curveEaseOut, animations: {
            self.loginTitleView.transform = .identity
            self.passwordTitleView.transform = .identity
        }, completion: nil)
    }
    
    private func animateTitleAppearing() {
        self.titleView.transform = CGAffineTransform(translationX: 0, y: -self.view.bounds.height/2)
        
        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.titleView.transform = .identity
        }, completion: nil)
    }
    
    private func animateFieldsAppearing() {
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 1
        fadeInAnimation.beginTime = CACurrentMediaTime() + 1
        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        fadeInAnimation.fillMode = CAMediaTimingFillMode.backwards
        
        self.usernameTextField.layer.add(fadeInAnimation, forKey: nil)
        self.passwordTextField.layer.add(fadeInAnimation, forKey: nil)
    }
    
    private func animateAuthButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.logInButton.layer.add(animation, forKey: nil)
    }
    
}
