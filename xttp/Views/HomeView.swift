//
//  ContentView.swift
//  xttp
//
//  Created by Wender on 11/02/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [ItemRequestModel]
    
    @State private var showingAlert = false
    
    @State private var editingItem: ItemRequestModel = ItemRequestModel(name: "request")
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        RequestView(item)
                    } label: {
                        HStack(alignment: .center) {
                            Circle()
                                .fill(VerbRequestModel(rawValue: item.type)?.colored() ?? .white)
                                .frame(width: 8, height: 8)
                            Text(item.name)
                        }
                        .contextMenu {
                            Button("Rename") {
                                editingItem = item
                                showingAlert = true
                            }
                            
                            Button("Delete") {
                                deleteItem(item: item)
                            }
                        }
                    }
                }
                
                Button(action: addItem) {
                    Label("New request", systemImage: "sparkle")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationSplitViewColumnWidth(min: 220, ideal: 250)
            .alert("New name", isPresented: $showingAlert) {
                TextField("Name", text: $editingItem.name)
                Button("OK") { }
            }
//            .toolbar {
//                ToolbarItem(placement: .primaryAction) {
//                    Button(action: addItem) {
//                        Label("Run", systemImage: "play.fill")
//                    }
//                }
//            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = ItemRequestModel(name: "New request")
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItem(item: ItemRequestModel) {
        withAnimation {
            modelContext.delete(item)
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: ItemRequestModel.self, inMemory: true)
}
