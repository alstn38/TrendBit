//
//  SceneDelegate.swift
//  TrendBit
//
//  Created by 강민수 on 3/6/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let tabBarController = TrendBitTabBarController()
        window = UIWindow(windowScene: scene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        NetworkMonitorManager.shared.startMonitoring()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        NetworkMonitorManager.shared.stopMonitoring()
    }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}
