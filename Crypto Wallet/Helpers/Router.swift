//
//  Router.swift
//  Crypto Wallet
//
//  Created by 123 on 31.01.23.
//

import UIKit

protocol RouterNavigationProtocol {
    var navigationViewController: UINavigationController? { get set }
}

protocol RouterProtocol {
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
    func initialViewController() -> UIViewController
    func pushToCrypto(loginVC: UIViewController)
    func pushToDetails(coinDetails: Coin?)
    func logOutToLoginVC(currentVC: UIViewController)
}

final class RouterWithoutNavVC: RouterProtocol, RouterNavigationProtocol {
    var navigationViewController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationViewController: UINavigationController?, assemblyBuilder: AssemblyBuilderProtocol?) {
        self.navigationViewController = navigationViewController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() -> UIViewController {
        guard let loginViewController = assemblyBuilder?.createLoginVC(router: self) else { return UIViewController() }
        return loginViewController
    }
    
    func pushToCrypto(loginVC: UIViewController) {
        let loginVC = loginVC
        if let navigationViewController = navigationViewController {
            guard let cryptoViewController = assemblyBuilder?.createCryptoVC(router: self) else { return }
            navigationViewController.viewControllers = [cryptoViewController]
            navigationViewController.modalPresentationStyle = .fullScreen
            loginVC.present(navigationViewController, animated: true, completion: nil)
        }
    }
    
    func pushToDetails(coinDetails: Coin?) {
        if let navigationViewController = navigationViewController {
            guard let detailsViewController = assemblyBuilder?.createDetailsVC(router: self, coinDetails: coinDetails) else { return }
            navigationViewController.pushViewController(detailsViewController, animated: true)
        }
    }
    
    func logOutToLoginVC(currentVC: UIViewController) {
        let currentVC = currentVC
        guard let loginViewController = assemblyBuilder?.createLoginVC(router: self) else { return }
        if let sceneDelegate = currentVC.view.window?.windowScene?.delegate as? SceneDelegate,
            let window = sceneDelegate.window {
            window.rootViewController = loginViewController
        }
    }
}
