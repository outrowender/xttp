//
//  HomeViewModel.swift
//  xttp
//
//  Created by Wender on 21/02/24.
//

import SwiftData
import SwiftUI

extension HomeView {
    
    @Observable
    class ViewModel {
        var modelContext: ModelContext
        
        var showingAlert = false
        var items: [ItemRequestModel] = []
        var editingItem: ItemRequestModel = ItemRequestModel(name: "request")
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            fetchData()
        }
        
        func fetchData() {
            do {
                let descriptor = FetchDescriptor<ItemRequestModel>(sortBy: [SortDescriptor(\.timestamp)])
                let query = try modelContext.fetch(descriptor)
                
                withAnimation {
                    items = query
                }
            } catch {
                print("Fetch failed. TODO: error handling")
            }
        }
        
        func addItem() {
            let newItem = ItemRequestModel(name: "New request")
            modelContext.insert(newItem)
            fetchData()
        }
        
        func deleteItem(item: ItemRequestModel) {
            modelContext.delete(item)
            fetchData() // TODO: remove only visually
        }
    }
}
