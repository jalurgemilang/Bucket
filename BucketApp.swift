//
//  BucketApp.swift
//  Bucket
//
//  Created by Long Fong Yee on 18/08/2024.
//

import SwiftUI

@main
struct BucketApp: App {
    let coreDataManager = CoreDataManager()
    @StateObject var cdvm: CoreDataViewModel
    
    init() {
        let viewModel = CoreDataViewModel(manager: coreDataManager)
        _cdvm = StateObject(wrappedValue: viewModel)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cdvm)
        }
    }
}
