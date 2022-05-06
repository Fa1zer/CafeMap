//
//  CafeMapApp.swift
//  CafeMap
//
//  Created by Artemiy Zuzin on 04.05.2022.
//

import SwiftUI
import Firebase

@main
struct CafeMapApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationCoordinator().start()
        }
    }
    
}
