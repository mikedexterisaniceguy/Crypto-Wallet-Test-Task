//
//  ViewController.swift
//  Crypto Wallet
//
//  Created by 123 on 31.01.23.
//

import UIKit

class LoginViewController: UIViewController {

    private let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        return scrollview
    }()
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
    private let cryptoWalletLabel: UILabel = {
        let label = UILabel()
        label.text = "Crypto Wallet"
        label.font = UIFont(name: "Avenir Next Bold", size: 30)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cryptoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "wallet")
        view.layer.cornerRadius = 100
        view.backgroundColor = UIColor(red: 230/255, green: 185/255, blue: 65/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let loginTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(red: 29/255, green: 30/255, blue: 35/255, alpha: 1)
        textField.textColor = .white
        textField.font = UIFont(name: "Avenir Next Demi Bold", size: 18)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Login",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 122/255, green: 123/255, blue: 128/255, alpha: 1)]
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(red: 29/255, green: 30/255, blue: 35/255, alpha: 1)
        textField.textColor = .white
        textField.font = UIFont(name: "Avenir Next Demi Bold", size: 18)
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 122/255, green: 123/255, blue: 128/255, alpha: 1)]
        )
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 20)
        button.backgroundColor = UIColor(red: 230/255, green: 185/255, blue: 65/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var textFieldsStackView = UIStackView()
    
    let userData = UserData()
    var presenter: LoginPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 19/255, green: 21/255, blue: 28/255, alpha: 1)
        
        setUpViews()
        setupDelegate()
        setConstraints()
        registerKeyboardNotification()
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    private func setupDelegate() {
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func setUpViews() {
        
        textFieldsStackView = UIStackView(arrangedSubviews: [loginTextField,
                                                   passwordTextField],
                                axis: .vertical,
                                spacing: 10,
                                distribution: .fillProportionally)
        textFieldsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(cryptoWalletLabel)
        backgroundView.addSubview(cryptoView)
        backgroundView.addSubview(textFieldsStackView)
        backgroundView.addSubview(loginButton)
        
        loginButton.addTarget(self, action: #selector(enterCryptoVC), for: .touchUpInside)
    }
    
    @objc private func enterCryptoVC() {
        presenter?.checkUserData()
    }
}

//MARK: - Implement LoginViewProtocol

extension LoginViewController: LoginViewProtocol {
    func isUserDataEqual() {
        if (loginTextField.text == userData.login) && (passwordTextField.text == userData.password) {
            presenter?.goToCryptoVC(vc: self)
        } else {
            alertOk(title: "Error", message: "Type the correct login or password")
        }
    }
}

//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}

//MARK: - Showing and hiding keyboard

extension LoginViewController {
    
    private func registerKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        let keyboardHeigth = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeigth.height / 3)
    }
    
    @objc private func keyboardWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
}

//MARK: - Set constraints

extension LoginViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cryptoView.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor, constant: view.frame.width / 3),
            cryptoView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            cryptoView.bottomAnchor.constraint(equalTo: textFieldsStackView.topAnchor, constant: -20),
            cryptoView.widthAnchor.constraint(equalToConstant: 200),
            cryptoView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            cryptoWalletLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            cryptoWalletLabel.bottomAnchor.constraint(equalTo: cryptoView.topAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            textFieldsStackView.topAnchor.constraint(equalTo: cryptoView.bottomAnchor, constant: 20),
            textFieldsStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            textFieldsStackView.widthAnchor.constraint(equalToConstant: view.frame.width / 1.5),
            textFieldsStackView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: textFieldsStackView.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 30),
            loginButton.widthAnchor.constraint(equalTo: textFieldsStackView.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

