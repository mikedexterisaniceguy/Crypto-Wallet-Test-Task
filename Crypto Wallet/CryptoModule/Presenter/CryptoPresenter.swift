//
//  CryptoPresenter.swift
//  Crypto Wallet
//
//  Created by 123 on 31.01.23.
//

import UIKit

protocol CryptoViewProtocol: AnyObject {
    func failure(error: Error)
    func manipulateActivity()
    func dynamicChangesPer1H(coins: [Coin], flag: Bool)
    func reloadTableView()
}

protocol CryptoPresenterProtocol: AnyObject {
    var coins: [Coin] { get set }
    var links: Links { get set }
    
    init(view: CryptoViewProtocol, router: RouterProtocol, network: NetworkService, links: Links)
    
    func getCoins()
    func dynamicOfChanges(coins: [Coin], flag: Bool) -> [Coin]
    func goToDetailsVC(coinDetails: Coin?)
    func logOutToLoginVC(currentVC: UIViewController)
}

final class CryptoPresenter: CryptoPresenterProtocol {
    let router: RouterProtocol
    let network: NetworkService?
    
    weak var view: CryptoViewProtocol?
    var coins = [Coin]()
    var links: Links
    
    required init(view: CryptoViewProtocol,  router: RouterProtocol, network: NetworkService, links: Links) {
        self.router = router
        self.network = network
        self.view = view
        self.links = links
        getCoins()
    }
    
    func getCoins() {
        let aGroup = DispatchGroup()
        
        for i in 0..<(links.coinsLinks.count) {
            aGroup.enter()
            
            network?.getCoinsAgain(urlString: links.coinsLinks[i]) { [weak self] result in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let coin):
                        self.coins.append(coin!)
                        aGroup.leave()
                    case .failure(let error):
                        self.view?.failure(error: error)
                        aGroup.leave()
                    }
                }
            }
        }
        
        aGroup.notify(queue: .main) {
            self.view?.reloadTableView()
        }
    }
    
    func dynamicOfChanges(coins: [Coin], flag: Bool) -> [Coin] {
        if flag == true {
            let sortedArray = coins.sorted(by: {$0.data.marketData.percentChangeLast1Hour ?? 2 > $1.data.marketData.percentChangeLast1Hour ?? 1 })
            return sortedArray
        } else {
            let sortedArray = coins.sorted(by: {$0.data.marketData.percentChangeLast1Hour ?? 2 < $1.data.marketData.percentChangeLast1Hour ?? 3})
            return sortedArray
        }
    }
    
    func goToDetailsVC(coinDetails: Coin?) {
        self.router.pushToDetails(coinDetails: coinDetails)
    }
    
    func logOutToLoginVC(currentVC: UIViewController) {
        self.router.logOutToLoginVC(currentVC: currentVC)
    }
}
