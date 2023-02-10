//
//  CryptoTableViewCell.swift
//  Crypto Wallet
//
//  Created by 123 on 31.01.23.
//

import Foundation
import UIKit

final class CryptoTableViewCell: UITableViewCell {
    
    private let coinItemView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor(red: 230/255, green: 185/255, blue: 65/255, alpha: 1)
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let coinSymbolLabel: UILabel = {
        let label = UILabel()
        label.text = "MKS"
        label.font = UIFont(name: "Avenir Next Bold", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let coinNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Kirill"
        label.font = UIFont(name: "Avenir Next", size: 14)
        label.textColor = UIColor(red: 112/255, green: 113/255, blue: 118/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let marketPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 1000.222"
        label.font = UIFont(name: "Avenir Next Bold", size: 18)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let percentChangeLabel: UILabel = {
        let label = UILabel()
        label.text = "+66,52342 %"
        label.font = UIFont(name: "Avenir Next", size: 14)
        label.textColor = UIColor(red: 112/255, green: 113/255, blue: 118/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var coinStackView = UIStackView()
    private var priceStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        self.backgroundColor = UIColor(red: 29/255, green: 30/255, blue: 35/255, alpha: 1)
        
        coinStackView = UIStackView(arrangedSubviews: [coinSymbolLabel, coinNameLabel],
                                    axis: .vertical,
                                    spacing: 0,
                                    distribution: .fill)
        coinStackView.alignment = .leading
        
        priceStackView = UIStackView(arrangedSubviews: [marketPriceLabel, percentChangeLabel],
                                     axis: .vertical,
                                     spacing: 0,
                                     distribution: .fill)
        priceStackView.alignment = .trailing
        
        self.addSubview(coinItemView)
        self.addSubview(coinStackView)
        self.addSubview(priceStackView)
    }
    
    func configurateCoinCell(coin: Coin?) {
        let priceUSD = coin?.data.marketData.priceUSD
        let percentChange1H = coin?.data.marketData.percentChangeLast1Hour
        self.coinSymbolLabel.text = coin?.data.symbol
        self.coinNameLabel.text = coin?.data.name
        self.marketPriceLabel.text = roundedPrice(priceUSD: priceUSD ?? 0.0)
        self.percentChangeLabel.text = setPercentChange(percent: percentChange1H ?? 0.0)
    }
    
    private func setPercentChange(percent: Double) -> String {
        if percent > 0 {
            self.percentChangeLabel.textColor = UIColor(red: 85/255, green: 138/255, blue: 116/255, alpha: 1)
            let roundedValue = round(percent * 100) / 100.0
            return "+" + "\(String(describing: roundedValue))" + " %"
        } else {
            self.percentChangeLabel.textColor = UIColor(red: 177/255, green: 75/255, blue: 92/255, alpha: 1)
            let roundedValue = round(percent * 100) / 100.0
            return "\(String(describing: roundedValue))" + " %"
        }
    }
    
    private func roundedPrice(priceUSD: Double) -> String {
        let roundedValue = round(priceUSD * 1000) / 1000.0
        return "$ " + "\(String(describing: roundedValue))"
    }
    
    func setCoinLabel() {
        setCoinView(coinNameLabel: coinNameLabel, coinImage: coinItemView)
    }
}

//MARK: - Set constraints

extension CryptoTableViewCell {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            coinItemView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinItemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            coinItemView.heightAnchor.constraint(equalToConstant: 50),
            coinItemView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            coinStackView.leadingAnchor.constraint(equalTo: coinItemView.trailingAnchor, constant: 10),
            coinStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            coinStackView.widthAnchor.constraint(equalToConstant: self.frame.width / 2.2)
        ])
        
        NSLayoutConstraint.activate([
            priceStackView.leadingAnchor.constraint(equalTo: coinStackView.trailingAnchor, constant: 10),
            priceStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            priceStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
