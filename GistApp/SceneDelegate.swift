//
//  SceneDelegate.swift
//  LuizaLabsTest
//
//  Created by Matheus Ramos on 21/05/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return }
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.windowScene = windowScene

        let navVC = UINavigationController()
        self.window?.rootViewController = navVC
        let coordinator = AppCoordinator(navigationController: navVC)
        coordinator.start()

        self.window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}

