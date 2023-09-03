//
//  SceneDelegate.swift
//  movies
//
//  Created by azun on 28/08/2023.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator : AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        Realm.migrateIfNeeded()
        
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        startApp()
        window?.makeKeyAndVisible()
        window?.tintColor = .label
    }
}

// MARK: - Private

private extension SceneDelegate {
    func startApp() {
        appCoordinator = AppCoordinator()
        appCoordinator?.start()
        window?.rootViewController = appCoordinator?.navigationController
    }
}
