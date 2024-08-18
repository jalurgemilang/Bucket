//
//  CoreDataManager.swift
//  Bucket
//
//  Created by Long Fong Yee on 18/08/2024.
//

import CoreData

class CoreDataManager {
    let container: NSPersistentCloudKitContainer
    
    init() {
        container = NSPersistentCloudKitContainer(name: "BucketContainer")
    }
    
    func loadCoreData(completion: @escaping (Bool) -> Void) {
        container.loadPersistentStores { description, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("^ Core Data loading error: \(error.localizedDescription)")
                    completion(false)
                    
                } else {
                    completion(true)
                }
            }
        }
    }
}
