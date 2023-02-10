//
//  AssemblyModuleBuilder.swift
//  Crypto Wallet
//
//  Created by 123 on 31.01.23.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
    func createLoginVC(router: RouterProtocol) -> UIViewController
    func createCryptoVC(router: RouterProtocol) -> UIViewController
    func createDetailsVC(router: RouterProtocol, coinDetails: Coin?) -> UIViewController
}

final class AssemblyModuleBuilder: AssemblyBuilderProtocol {
    func createLoginVC(router: RouterProtocol) -> UIViewController {
        let view = LoginViewController()
        let presenter = LoginPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
    
    func createCryptoVC(router: RouterProtocol) -> UIViewController {
        let view = CryptoViewController()
        let networkService = NetworkService()
        let links = Links()
        let presenter = CryptoPresenter(view: view, router: router, network: networkService, links: links)
        view.presenter = presenter
        return view
    }
    
    func createDetailsVC(router: RouterProtocol, coinDetails: Coin?) -> UIViewController {
        let view = DetailsViewController()
        let presenter = DetailsPresenter(view: view, router: router, coinDetails: coinDetails)
        view.presenter = presenter
        return view
    }
}
