//
//  LoginPresenter.swift
//  Crypto Wallet
//
//  Created by 123 on 31.01.23.
//

import Foundation
import UIKit

protocol LoginViewProtocol: AnyObject {
    func isUserDataEqual()
}

protocol LoginPresenterProtocol: AnyObject {
    init(view: LoginViewProtocol, router: RouterProtocol)
    
    func checkUserData()
    func goToCryptoVC(vc: UIViewController)
}

final class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    var router: RouterProtocol
    
    required init(view: LoginViewProtocol, router: RouterProtocol) {
        self.router = router
        self.view = view
    }
    
    func checkUserData() {
        self.view?.isUserDataEqual()
    }
    
    func goToCryptoVC(vc: UIViewController) {
        self.router.pushToCrypto(loginVC: vc)
    }
}

