//
//  CoreDataViewModel.swift
//  Bucket
//
//  Created by Long Fong Yee on 18/08/2024.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let manager: CoreDataManager
    
    @Published var savedEntities: [BucketEntity] = []
    @Published var isDataLoaded = false
    
    init(manager: CoreDataManager) {
        self.manager = manager
        loadData()
    }
    
    func loadData() {
        manager.loadCoreData { [weak self] result in
            DispatchQueue.main.async {
                self?.isDataLoaded = result
                if result {
                    self?.fetchBuckets()
                }
            }
        }
    }
    
    func fetchBuckets() {
        let request: NSFetchRequest<BucketEntity> = BucketEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]        
        do {
            savedEntities = try manager.container.viewContext.fetch(request)
        } catch let error {
            print("^ Error fetching \(error)")
        }
    }
    
    
    func addBucket(text: String) {
        let newBucket = BucketEntity(context: manager.container.viewContext)
        newBucket.id = UUID()
        newBucket.name = text
        print("^ func addBucket   : \(text)")
        savedData()
    }
    
    func deleteBucket(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        manager.container.viewContext.delete(entity)
        savedData()
    }
    
    
    func savedData() {
        do {
            try manager.container.viewContext.save()
            print("^ !!!!!!!!!!!!!!!!!!!!!!!! Sucessful savedData !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        } catch let error {
            print("^ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            print("^ !! Error saving data into CoreDataViewModel: \(error)")
            print("^ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        }
    }
    
   
    
}

