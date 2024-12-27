//
//  Delicios_notes_for_iOS_advanced_lvlApp.swift
//  Delicios notes for iOS advanced lvl
//
//  Created by Starfighter Dollie on 11.11.2024.
//

import SwiftUI

@main
struct Delicios_notes_for_iOS_advanced_lvlApp: App {
    @State var container: Injection = Injection()
    var body: some Scene {
        WindowGroup {
            MainView(container: container)
        }
    }
}

// translate api
