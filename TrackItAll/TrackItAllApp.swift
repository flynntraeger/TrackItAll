//
//  TrackItAllApp.swift
//  TrackItAll
//
//  Created by Flynn Traeger on 23/05/2021.
//

import SwiftUI

@main
struct TrackItAllApp: App {
    @StateObject var store = CategoryVM(named: "Final")
        
    var body: some Scene {
        WindowGroup {
            CategoriesHome().environmentObject(store)
        }
    }
}
