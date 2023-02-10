//
//  DetailsPresenter.swift
//  Crypto Wallet
//
//  Created by 123 on 31.01.23.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
    func setDetailInfo(coinDetails: Coin?)
    func setPercentChange1H(percent: Double) -> String
    func setPercentChange24H(percent: Double) -> String
    func roundedPrice(priceUSD: Double) -> String
    func setCoinLabel()
    func logout(currentVC: UIViewController)
}

protocol DetailsPresenterProtocol: AnyObject {
    init(view: DetailsViewProtocol, router: RouterProtocol, coinDetails: Coin?)
    
    func setDetails()
    func logOutToLoginVC(currentVC: UIViewController)
}

final class DetailsPresenter: DetailsPresenterProtocol {
    weak var view: DetailsViewProtocol?
    var router: RouterProtocol
    var coinDetails: Coin?
    
    required init(view: DetailsViewProtocol, router: RouterProtocol, coinDetails: Coin?) {
        self.router = router
        self.view = view
        self.coinDetails = coinDetails
    }
    
    func setDetails() {
        self.view?.setDetailInfo(coinDetails: coinDetails)
    }
    
    func logOutToLoginVC(currentVC: UIViewController) {
        self.router.logOutToLoginVC(currentVC: currentVC)
    }
}
