//
//  VideoUploaderApp.swift
//  VideoUploader
//
//  Created by cmStudent on 2023/08/10.
//

import SwiftUI
import FirebaseCore

class AppDelegate : NSObject , UIApplicationDelegate {
  func application ( _ application : UIApplication ,
                   didFinishLaunchingWithOptions launchOptions : [ UIApplication . LaunchOptionsKey : Any ]? = nil ) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct VideoUploaderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
