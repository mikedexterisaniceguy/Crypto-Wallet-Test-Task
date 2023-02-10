//
//  CryptoViewController.swift
//  Crypto Wallet
//
//  Created by 123 on 31.01.23.
//

import UIKit

final class CryptoViewController: UIViewController {
    
    private let changeDynamicsOfCoin: UIButton = {
        let button = UIButton()
        button.setTitle("One hour price changes", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 18)
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor(red: 230/255, green: 185/255, blue: 65/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cryptoTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(red: 29/255, green: 30/255, blue: 35/255, alpha: 1)
        tableView.rowHeight = 80
        tableView.layer.cornerRadius = 5
        tableView.bounces = false
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: "Crypto")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var activityIndicator = UIActivityIndicatorView(style: .large)
    var presenter: CryptoPresenterProtocol!
    private var flag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        manipulateActivity()
        setUpDelegates()
        setConstraints()
        setNavigationBar()
    }
    
    private func setUpViews() {
        view.backgroundColor = UIColor(red: 19/255, green: 21/255, blue: 28/255, alpha: 1)
        
        view.addSubview(cryptoTableView)
        view.addSubview(changeDynamicsOfCoin)
        view.addSubview(activityIndicator)
        
        changeDynamicsOfCoin.addTarget(self, action: #selector(tapToDynamic), for: .touchUpInside)
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Crypto rates"
        let logoutBarButtonItem = UIBarButtonItem(systemItem: .reply)
        logoutBarButtonItem.target = self
        logoutBarButtonItem.action = #selector(logout)
        navigationItem.rightBarButtonItem = logoutBarButtonItem
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().tintColor = .white
    }
    
    private func setUpDelegates() {
        cryptoTableView.delegate = self
        cryptoTableView.dataSource = self
    }
    
    @objc private func tapToDynamic() {
        dynamicChangesPer1H(coins: self.presenter.coins, flag: flag)
        cryptoTableView.reloadData()
    }
}

//MARK: - Implement CryptoViewProtocol

extension CryptoViewController: CryptoViewProtocol {

    func failure(error: Error) {
        print(error)
    }
    
    func manipulateActivity() {
        activityIndicator.center = view.center
        activityIndicator.color = UIColor(red: 230/255, green: 185/255, blue: 65/255, alpha: 1)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    func dynamicChangesPer1H(coins: [Coin], flag: Bool) {
        let newArray = presenter.dynamicOfChanges(coins: coins, flag: flag)
        self.presenter.coins = newArray
        if flag == true {
            self.flag = false
            self.changeDynamicsOfCoin.setTitle("From higher to lower", for: .normal)
        } else {
            self.flag = true
            self.changeDynamicsOfCoin.setTitle("From lower to higher", for: .normal)
        }
    }
    
    @objc func logout(currentVC: UIViewController) {
        self.presenter.logOutToLoginVC(currentVC: self)
    }
}

//MARK: - UITableViewDelegate and UITableViewDataSource

extension CryptoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = presenter.coins[indexPath.row]
        presenter.goToDetailsVC(coinDetails: coin)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CryptoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Crypto", for: indexPath) as! CryptoTableViewCell
        let coin = (presenter.coins[indexPath.row])
        cell.configurateCoinCell(coin: coin)
        cell.setCoinLabel()
        return cell
    }
    
    func reloadTableView() {
        self.cryptoTableView.reloadData()
        self.activityIndicator.stopAnimating()
    }
}



//MARK: - Set constraints

extension CryptoViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            changeDynamicsOfCoin.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            changeDynamicsOfCoin.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            changeDynamicsOfCoin.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            changeDynamicsOfCoin.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            cryptoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            cryptoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            cryptoTableView.topAnchor.constraint(equalTo: changeDynamicsOfCoin.bottomAnchor, constant: 15),
            cryptoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15)
        ])
    }
}
