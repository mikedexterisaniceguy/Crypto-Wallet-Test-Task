//
//  DetailsViewController.swift
//  Crypto Wallet
//
//  Created by 123 on 31.01.23.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    private let coinItemView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(red: 230/255, green: 185/255, blue: 65/255, alpha: 1)
        view.layer.cornerRadius = 100
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let coinSymbolLabel: UILabel = {
        let label = UILabel()
        label.text = "BTC"
        label.font = UIFont(name: "Avenir Next Bold", size: 24)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let coinNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bitcoin"
        label.font = UIFont(name: "Avenir Next", size: 22)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let marketCapRankLabel: UILabel = {
        let label = UILabel()
        label.text = "Market cap rank"
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let marketCapRankValueLabel: UILabel = {
        let label = UILabel()
        label.text = "#1"
        label.font = UIFont(name: "Avenir Next Bold", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let marketPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price in USD"
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let marketPriceValueLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 1000.222"
        label.font = UIFont(name: "Avenir Next Bold", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let percentChangePerHourLabel: UILabel = {
        let label = UILabel()
        label.text = "Change 1H"
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let percentChangePerHourValueLabel: UILabel = {
        let label = UILabel()
        label.text = "+66,52342 %"
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let percentChangePerDayLabel: UILabel = {
        let label = UILabel()
        label.text = "Change 24H"
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let percentChangePerDayValueLabel: UILabel = {
        let label = UILabel()
        label.text = "+66,52342 %"
        label.font = UIFont(name: "Avenir Next", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Bold", size: 20)
        button.backgroundColor = UIColor(red: 230/255, green: 185/255, blue: 65/255, alpha: 1)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var labelsStackView = UIStackView()
    private var valuesStackView = UIStackView()
    
    var presenter: DetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        setConstraints()
        presenter.setDetails()
        setCoinLabel()
    }
    
    private func setUpViews() {
        view.backgroundColor = UIColor(red: 19/255, green: 21/255, blue: 28/255, alpha: 1)
        navigationItem.title = "Coin details"
        
        labelsStackView = UIStackView(arrangedSubviews: [marketCapRankLabel,
                                                         marketPriceLabel,
                                                         percentChangePerHourLabel,
                                                         percentChangePerDayLabel],
                                    axis: .vertical,
                                    spacing: 10,
                                    distribution: .fill)
        labelsStackView.alignment = .leading
        
        valuesStackView = UIStackView(arrangedSubviews: [marketCapRankValueLabel,
                                                        marketPriceValueLabel,
                                                        percentChangePerHourValueLabel,
                                                        percentChangePerDayValueLabel],
                                     axis: .vertical,
                                     spacing: 10,
                                     distribution: .fill)
        valuesStackView.alignment = .trailing
        
        view.addSubview(coinItemView)
        view.addSubview(coinSymbolLabel)
        view.addSubview(coinNameLabel)
        view.addSubview(labelsStackView)
        view.addSubview(valuesStackView)
        view.addSubview(logOutButton)
        
        logOutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
}

//MARK: - Implement DetailsViewProtocol

extension DetailsViewController: DetailsViewProtocol {

    func setDetailInfo(coinDetails: Coin?) {
        let rankCap = coinDetails?.data.marketCap.rank
        let priceUSD = coinDetails?.data.marketData.priceUSD
        let percentChange1H = coinDetails?.data.marketData.percentChangeLast1Hour
        let percentChange24H = coinDetails?.data.marketData.percentChangeLast24Hours
        self.coinSymbolLabel.text = coinDetails?.data.symbol
        self.coinNameLabel.text = coinDetails?.data.name
        self.marketCapRankValueLabel.text = "\(String(describing: rankCap ?? 0))"
        self.marketPriceValueLabel.text = roundedPrice(priceUSD: priceUSD ?? 0.0)
        self.percentChangePerHourValueLabel.text = setPercentChange1H(percent: percentChange1H ?? 0.0)
        self.percentChangePerDayValueLabel.text = setPercentChange24H(percent: percentChange24H ?? 0.0)
    }
    
    func setPercentChange1H(percent: Double) -> String {
        if percent > 0 {
            self.percentChangePerHourValueLabel.textColor = UIColor(red: 85/255, green: 138/255, blue: 116/255, alpha: 1)
            let roundedValue = round(percent * 100) / 100.0
            return "+" + "\(String(describing: roundedValue))" + " %"
        } else {
            self.percentChangePerHourValueLabel.textColor = UIColor(red: 177/255, green: 75/255, blue: 92/255, alpha: 1)
            let roundedValue = round(percent * 100) / 100.0
            return "\(String(describing: roundedValue))" + " %"
        }
    }
    
    func setPercentChange24H(percent: Double) -> String {
        if percent > 0 {
            self.percentChangePerDayValueLabel.textColor = UIColor(red: 85/255, green: 138/255, blue: 116/255, alpha: 1)
            let roundedValue = round(percent * 100) / 100.0
            return "+" + "\(String(describing: roundedValue))" + " %"
        } else {
            self.percentChangePerDayValueLabel.textColor = UIColor(red: 177/255, green: 75/255, blue: 92/255, alpha: 1)
            let roundedValue = round(percent * 100) / 100.0
            return "\(String(describing: roundedValue))" + " %"
        }
    }
    
    func roundedPrice(priceUSD: Double) -> String {
        let roundedValue = round(priceUSD * 1000) / 1000.0
        return "$ " + "\(String(describing: roundedValue))"
    }
    
    func setCoinLabel() {
        setCoinView(coinNameLabel: coinNameLabel, coinImage: coinItemView)
    }
    
    @objc func logout(currentVC: UIViewController) {
        self.presenter.logOutToLoginVC(currentVC: self)
    }
}

//MARK: - Set constraints

extension DetailsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            coinItemView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coinItemView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            coinItemView.widthAnchor.constraint(equalToConstant: 200),
            coinItemView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            coinSymbolLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coinSymbolLabel.topAnchor.constraint(equalTo: coinItemView.bottomAnchor, constant: 15),
        ])
        
        NSLayoutConstraint.activate([
            coinNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coinNameLabel.topAnchor.constraint(equalTo: coinSymbolLabel.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            labelsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            labelsStackView.topAnchor.constraint(equalTo: coinNameLabel.bottomAnchor, constant: 30),
            labelsStackView.widthAnchor.constraint(equalToConstant: view.frame.width / 1.4)
        ])
        
        NSLayoutConstraint.activate([
            valuesStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            valuesStackView.topAnchor.constraint(equalTo: coinNameLabel.bottomAnchor, constant: 30),
            valuesStackView.widthAnchor.constraint(equalToConstant: view.frame.width / 1.4)
        ])
        
        NSLayoutConstraint.activate([
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            logOutButton.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
