//
//  WordbookApp.swift
//  Wordbook
//
//  Created by Yu Takahashi on 2020/09/30.
//

import SwiftUI
import GoogleMobileAds

@main
struct WordbookApp: App {
    @StateObject private var screenController = ScreenController.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch screenController.state {
                case .auth: WelcomeView()
                case .main: WordbooksView()
                case .loading: LoadingView()
                }
            }
            .animation(.easeInOut, value: screenController.state)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Initialize Mobile Ads SDK
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        #if DEBUG
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ GADSimulatorID ]
        #else
        if isTestFlight {
            GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ GADSimulatorID ]
        }
        #endif
        
        return true
    }
}
