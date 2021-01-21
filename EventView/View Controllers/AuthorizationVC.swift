//
//  AuthorizationVC.swift
//  EventView
//
//  Created by Ludovico Veniani on 1/20/21.
//

import UIKit
import IQKeyboardManagerSwift

class AuthorizationVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    //MARK: Variables
    var isRegistration: Bool!
    
    
    
    //MARK: Views
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = largeFontBold
        lbl.text = "Welcome to Event View"
        
        return lbl
    }()
        
    
    lazy var Vstack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fillEqually
        view.addBackground(color: UIColor.lightGray.withAlphaComponent(0.1), cornerRadius: 10)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var loginContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view.textContainerView(view: view, UIImage(systemName: "person")!.withTintColor(.black, renderingMode: .alwaysOriginal), loginTextField!, lineColor: UIColor.black)
    }()
    
    lazy var loginTextField: UITextField? = {
        var tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf = tf.textField(withPlaceolder: "Username", textColor: UIColor.black, isSecureTextEntry: false, isTextEntry: true)
        tf.autocapitalizationType = .none
        return tf
    }()
    
    lazy var passwordContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view.textContainerView(view: view, UIImage(systemName: "lock")!.withTintColor(.black, renderingMode: .alwaysOriginal), passwordTextField!, lineColor: UIColor.black)
    }()
    
    lazy var passwordTextField: UITextField? = {
        var tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf.textField(withPlaceolder: "Password", textColor: UIColor.black, isSecureTextEntry: true, isTextEntry: true)
    }()
    
    
    lazy var submitBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.mainBlue()
        button.titleLabel?.font = mediumFontBold
        button.addTarget(self, action: #selector(submitBtnTapped), for: .touchUpInside)
        button.layer.cornerRadius = 25
        return button
    }()
    
    lazy var switchContextBtn: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: mediumFont, NSAttributedString.Key.foregroundColor: UIColor.gray])
        attributedTitle.append(NSAttributedString(string: "Sign up", attributes: [NSAttributedString.Key.font: mediumFontBold, NSAttributedString.Key.foregroundColor: UIColor.black,]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(switchContextBtnTapped), for: .touchUpInside)
        return button
    }()
    

    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .black
        spinner.startAnimating()
        spinner.alpha = 1
        spinner.isHidden = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    
    //MARK: Helper Functions
    func setup(isRegistration: Bool) {
        self.isRegistration = isRegistration
        
        
        view.backgroundColor = .white
        
        
        
        view.addSubview(Vstack)
        
        Vstack.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: view.frame.width-64, height: 116)
        Vstack.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.frame.width).isActive = true
        Vstack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        
        
        
        
        view.addSubview(titleLbl)
        titleLbl.anchor(top: nil, left: nil, bottom: Vstack.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 24, paddingRight: 0, width: view.frame.height/4, height: view.frame.height/4)
        titleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        Vstack.addArrangedSubview(loginContainerView)
        loginContainerView.anchor(top: nil, left: Vstack.leftAnchor, bottom: nil, right: Vstack.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        Vstack.addArrangedSubview(passwordContainerView)
        passwordContainerView.anchor(top: nil, left: Vstack.leftAnchor, bottom: nil, right: Vstack.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        view.addSubview(submitBtn)
        submitBtn.anchor(top: passwordContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        submitBtn.setTitle(isRegistration ? "Register" : "Login", for: .normal)
        
        view.addSubview(spinner)
        spinner.anchor(top: passwordContainerView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 9, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
 
        
        view.addSubview(switchContextBtn)
        switchContextBtn.anchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 6, paddingRight: 32, width: 0, height: 25)
        
        
    }
    
    func showMessage(message: String) {
        
        DispatchQueue.main.async {
            let label = self.createLbl(text: message)
            
            self.view.addSubview(label)
            label.alpha = 1
            
            label.frame = CGRect(x: 0 ,y: self.view.frame.height, width: (self.view.frame.width/4)*3, height: 50)
            label.center.x = self.view.center.x
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                label.frame = CGRect(x: 0, y: self.view.frame.height - 120, width: (self.view.frame.width/4)*3, height: 50)
                label.center.x = self.view.center.x
            }, completion: { _ in
                UIView.animate(withDuration: 2, delay: 2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                    label.alpha = 0
                }, completion: { _ in
                    
                    label.removeFromSuperview()
                    label.alpha = 1
                })
            })
        }
        
    }
    
    func createLbl(text: String) -> UILabel {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.rgb(red: 209, green: 21, blue: 0)
        lbl.textColor = .white
        lbl.text = text
        lbl.font = smallFont //UIFont.italicSystemFont(ofSize: 15.0)
        //lbl.sizeToFit()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth  = true
        lbl.layer.cornerRadius = 10
        return lbl
    }
    
    
    //MARK: Selectors
    
    @objc func submitBtnTapped() {
        if loginTextField!.text!.isEmpty || passwordTextField!.text!.isEmpty {
            showMessage(message: "Enter a username and password")
            return
        }
        
        
        //Store login info
        UserDefaults.standard.setValue(self.loginTextField!.text!, forKey: "username")
        UserDefaults.standard.setValue(self.passwordTextField!.text!, forKey: "password")

        
        spinner.isHidden = false
        
        if isRegistration {
            AuthAPI.signUpUser() { result in
                switch result {
                case .success(let statusCode):
                    if statusCode != 200 {
                        self.showMessage(message: "Username taken, please choose a different one.")
                    } else {
                        self.successfullLogin()
                    }
                case .failure(let error):
                    self.showMessage(message: "Oops, check your connection.")
                    
                }
                self.spinner.isHidden = true
            }
        } else {
            AuthAPI.loginUser() { result in
                switch result {
                case .success(let statusCode):
                    if statusCode != 200 {
                        self.showMessage(message: "Unable to login. Check your username and password. ")
                    } else {
                        self.successfullLogin()
                    }
                case .failure(let error):
                    self.showMessage(message: "Oops, check your connection.")
                    
                }
                self.spinner.isHidden = true
            }
        }
        
    }
    
    func successfullLogin() {
        UserDefaults.standard.setValue(true, forKey: "isLoggedIn")
        
        containerVC.configureViewComponents()
        self.navigationController?.popViewController(animated: false)
    }
    
    @objc func switchContextBtnTapped() {
        if isRegistration {
            submitBtn.setTitle("Login", for: .normal)
            
            
            let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: mediumFont, NSAttributedString.Key.foregroundColor: UIColor.gray])
            attributedTitle.append(NSAttributedString(string: "Sign up", attributes: [NSAttributedString.Key.font: mediumFontBold, NSAttributedString.Key.foregroundColor: UIColor.black,]))
            switchContextBtn.setAttributedTitle(attributedTitle, for: .normal)
        } else {
            submitBtn.setTitle("Register", for: .normal)
            
            
            let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: mediumFont, NSAttributedString.Key.foregroundColor: UIColor.gray])
            attributedTitle.append(NSAttributedString(string: "Log in", attributes: [NSAttributedString.Key.font: mediumFontBold, NSAttributedString.Key.foregroundColor: UIColor.black,]))
            switchContextBtn.setAttributedTitle(attributedTitle, for: .normal)
        }
        
        isRegistration.toggle()
    }
    
    
}


//MARK: Delegates
