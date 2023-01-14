//
//  DiaryApp.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/01/10.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct DiaryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var avocadoStore: AvocadoStore = AvocadoStore()
    @StateObject var locationService: LocationService = LocationService()

    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(avocadoStore)
            .environmentObject(locationService)
//            PhotosPickerTest()
//                        .environmentObject(avocadoStore)

        }
    }
}
