//
//  BucketApp.swift
//  Bucket
//
//  Created by Long Fong Yee on 18/08/2024.
//

import SwiftUI

@main
struct BucketApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
