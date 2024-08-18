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
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Add bucket here...", text: $textFieldText)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button(action: {
                    guard !textFieldText.isEmpty else { return }
                    cdvm.addBucket(text: textFieldText)
                    textFieldText = ""
                    
                }, label: {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .cornerRadius(10)
                    
                })
                .padding(.horizontal)
                
                List {
                    ForEach(cdvm.savedEntities) { entity in
                        HStack {
                            Text(entity.name ?? "No Name")
                        }
                    }
                    .onDelete(perform: cdvm.deleteBucket)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Buckets")
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
