//
//  Pick_and_PackApp.swift
//  Pick and Pack
//
//  Created by BERRADA on 22/11/2021.
//

import SwiftUI

@main
struct Pick_and_PackApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Orders())
        }
    }
}
