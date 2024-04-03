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
        var selectedItem: Int
        
        var editingItem: ItemRequestModel = ItemRequestModel(name: "request")
        
        init(modelContext: ModelContext) {
            _modelContext = modelContext
            selectedItem = 0
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
            let newItem = ItemRequestModel(name: "New request", headers: [
                .init(key: "Accept", required: true, value: "*/*"),
                .init(key: "Accept-Encoding", required: true, value: "*"),
                .init(key: "Accept-Language", required: true, value: "*"),
            ])
            modelContext.insert(newItem)
            fetchData()
        }
        
        func renameSelectedItem(item: Int? = nil) {
            let item = items[item ?? selectedItem]
            editingItem = item
            showingAlert = true
        }
        
        func deleteSelectedItem(item: Int? = nil) {
            let markedItem = item ?? selectedItem
            
            let item = items[markedItem]
            if items.count == markedItem + 1 {
                selectedItem = items.count - 2
            }
            modelContext.delete(item)
            fetchData() // TODO: remove only visually
        }
    }
}
