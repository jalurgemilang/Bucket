//
//  ContentView.swift
//  Bucket
//
//  Created by Long Fong Yee on 18/08/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var cdvm: CoreDataViewModel
    
    var body: some View {
        VStack {
            ForEach(cdvm.buckets, id: \.self) { bucket in
                VStack {
                    Text(bucket.name ?? "No Name")
                    if let items = bucket.items?.allObjects as? [ItemEntity] {
                        ForEach(items, id: \.self) { item in
                            Text(item.name ?? "No Item Name")
                        }
                    }
                }
            }
        }
    }
}
    


    
//MARK: PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let cdvm = CoreDataViewModel(manager: CoreDataManager())
        
        ContentView()
            .environmentObject(cdvm)
    }
}
