//
//  TrendBitTabBarController.swift
//  TrendBit
//
//  Created by 강민수 on 3/6/25.
//

import UIKit

final class TrendBitTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBar()
    }
    
    private func configureTabBar() {
        view.backgroundColor = UIColor(resource: .trendBitWhite)
        configureTabBarController()
        configureTabBarAppearance()
    }
    
    private func configureTabBarController() {
        let viewModel = ExchangeViewModel()
        let exchangeViewController = ExchangeViewController(viewModel: viewModel)
        exchangeViewController.tabBarItem = UITabBarItem(
            title: StringLiterals.TapBar.exchangeTitle,
            image: ImageAssets.chartLineUptrendAxis,
            selectedImage: ImageAssets.chartLineUptrendAxis
        )
        
        let coinInfoViewController = CoinInfoViewController()
        coinInfoViewController.tabBarItem = UITabBarItem(
            title: StringLiterals.TapBar.coinInfoTitle,
            image: ImageAssets.chartBarFill,
            selectedImage: ImageAssets.chartBarFill
        )
        
        let portfolioViewController = PortfolioViewController()
        portfolioViewController.tabBarItem = UITabBarItem(
            title: StringLiterals.TapBar.portfolioTitle,
            image: ImageAssets.star,
            selectedImage: ImageAssets.star
        )
        
        let exchangeNavigationController = UINavigationController(rootViewController: exchangeViewController)
        let coinInfoNavigationController = UINavigationController(rootViewController: coinInfoViewController)
        let portfolioNavigationController = UINavigationController(rootViewController: portfolioViewController)
        exchangeNavigationController.isNavigationBarHidden = true
        coinInfoNavigationController.isNavigationBarHidden = true
        portfolioNavigationController.isNavigationBarHidden = true
        setViewControllers(
            [exchangeNavigationController, coinInfoNavigationController, portfolioNavigationController],
            animated: true
        )
    }
    
    private func configureTabBarAppearance() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(resource: .trendBitWhite)
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(resource: .trendBitNavy)
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        tabBar.tintColor = UIColor(resource: .trendBitNavy)
    }
}
