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
    @Published var buckets: [BucketEntity] = []
    @Published var items:   [ItemEntity] = []
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
            buckets = try manager.container.viewContext.fetch(request)
        } catch let error {
            print("^ Error fetching \(error)")
        }
    }
    
    func fetchItems() {
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        
        do {
            items = try manager.container.viewContext.fetch(request)
        } catch let error {
            print ("Error fetching \(error.localizedDescription)")
        }
    }
    
    func fetchItems(forBucket bucket: BucketEntity) {
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        //******************************************
        //**
        //** NOTE THIS WAY OF FILTERING
        //** only for 1 to 1 relationship
        let filter = NSPredicate(format: "bucket == %@", bucket)
        request.predicate = filter
        
        do {
            items = try manager.container.viewContext.fetch(request)
        } catch let error {
            print ("Error fetching \(error.localizedDescription)")
        }
    }
    
    func addBucket(text: String) {
        let newBucket = BucketEntity(context: manager.container.viewContext)
        newBucket.id = UUID()
        newBucket.name = text
        print("^ func addBucket   : \(text)")
        savedData()
    }
    
    func addItem() {
        let newItem = ItemEntity(context: manager.container.viewContext)
        newItem.qty = 20
        newItem.price = 10
        newItem.status = "buy"
        
        newItem.bucket = buckets[2] //One to One relationship, so not NSSet array
        savedData()
    }
    
    func deleteBucket(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = buckets[index]
        manager.container.viewContext.delete(entity)
        savedData()
    }
    
    
    func savedData() {
        buckets.removeAll()
        items.removeAll()
        
        do {
            try manager.container.viewContext.save()
            self.fetchBuckets()
            self.fetchItems()
            print("^ !! Sucessful savedData")
        } catch let error {
            print("^ !! Error saving data into CoreDataViewModel: \(error)")
        }
    }
    
   
    
}

