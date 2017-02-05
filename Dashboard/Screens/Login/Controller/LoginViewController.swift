//
//  LoginViewController.swift
//  Dashboard
//
//  Created by Mykola Denysyuk on 2/3/17.
//  Copyright © 2017 Mykola Denysyuk. All rights reserved.
//

import UIKit

protocol ILoginControllerDelegate {
    func loginCompleted(credentials:LoginCredentials)
    func loginDataProvider() -> DataProvider<LoginStorage>
}

class LoginViewController: UIViewController {

    // MARK: Vars
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private(set) var storage = LoginStorage() {
        didSet {_configureViews()}
    }
    var delegate:ILoginControllerDelegate!
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        _registerForKeyboardNotifications()
        /*
        let dataProvider = delegate!.loginDataProvider()
        dataProvider.loadData { (success, storage, error) in
            guard
                let storage = storage, success
                else {
                    error_impossibleCondition("storage is required. error" +
                        (error?.localizedDescription ?? ""))
            }
            
            self.storage = storage
        }*/
    }

    
    // MARK: Actions

    private func _configureViews() {
        if storage.isRememberMe {
            loginField.text = storage.lastLogin
            passwordField.text = storage.lastPassword
        }
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        _doLogin()
    }
    
    fileprivate func _doLogin() {
        guard
            let login = loginField.text,
            let password = passwordField.text
            else {return /* TODO: show alert*/}
        let result = LoginCredentials(login: login, password: password)
        delegate.loginCompleted(credentials: result)
    }
    
}


// MARK: Keyboard

extension LoginViewController {
    
    fileprivate func _registerForKeyboardNotifications() {
        let center = NotificationCenter.default
        
        center.addObserver(
            self,
            selector: #selector(keyboardWillAppear(_:)),
            name: .UIKeyboardWillShow,
            object: nil)
        center.addObserver(
            self,
            selector: #selector(keyboardWillDisappear(_:)),
            name: .UIKeyboardWillShow,
            object: nil)
    }
    
    func keyboardWillAppear(_ notification:Notification) {
        guard let
            userInfo = (notification as NSNotification).userInfo,
            let keyboardFrameValue = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
                return
        }
        
        _addInsets(keyboardFrame: keyboardFrameValue.cgRectValue)
    }
    
    func keyboardWillDisappear(_ notification:Notification) {
        _addInsets(false)
    }
    
    fileprivate func _addInsets(_ isAdd:Bool = true, keyboardFrame:CGRect=CGRect.zero) {
        guard let window = view.window else {
            fatalError("Impossible to perform w/o window")
        }
        if isAdd {
            let loginButtonConvertedFrame = window.convert(
                loginButton.frame,
                from: loginButton.superview)
            let intersection = loginButtonConvertedFrame.intersection(keyboardFrame)
            if intersection.height > 0 {
                scrollView.contentInset = UIEdgeInsets(
                    top: 0,
                    left: 0,
                    bottom: intersection.height,
                    right: 0)
            }
        } else {
            scrollView.contentInset = UIEdgeInsets.zero
        }
    }
}

// MARK: Textfield

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginField {
            passwordField.becomeFirstResponder()
        } else {
            _doLogin()
        }
        return true
    }
    
}
