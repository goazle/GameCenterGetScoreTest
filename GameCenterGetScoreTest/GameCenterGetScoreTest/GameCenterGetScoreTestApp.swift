//
//  GameCenterGetScoreTestApp.swift
//  GameCenterGetScoreTest
//
//  Created by goazle on 2022/06/01.
//

import SwiftUI
import GameKit

@main
struct GameCenterGetScoreTestApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            GameCenterGetScoreView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Show GameCenter AccessPoint
        GKAccessPoint.shared.location = .topLeading
        GKAccessPoint.shared.showHighlights = true
        GKAccessPoint.shared.isActive = true

        // Call GameCenter authentication
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        if let _ = window.rootViewController {
            print("GameCenterのログイン処理を呼び出します")
            GameCenterHelper.loginGameCenter()
        }
        return true
    }

}
