//
//  SceneDelegate.swift
//  Crypto Wallet
//
//  Created by 123 on 31.01.23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let assembly = AssemblyModuleBuilder()
        let navVC = UINavigationController()
        let router = RouterWithoutNavVC(navigationViewController: navVC, assemblyBuilder: assembly)
        
        window.rootViewController = router.initialViewController()
        window.makeKeyAndVisible()
        self.window = window
        
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont(name: "Avenir Next Bold", size: 20)!,
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            navigationBarAppearance.backgroundColor = UIColor(red: 230/255, green: 185/255, blue: 65/255, alpha: 1)
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }
}

