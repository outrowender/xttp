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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        RequestView(item)
                    } label: {
                        HStack {
                            Circle()
                                .fill(VerbRequestModel(rawValue: item.type)?.colored() ?? .white)
                                .frame(width: 8, height: 8)
                            Text(item.name)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
                
                Button(action: addItem) {
                    Label("New request", systemImage: "sparkle")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationSplitViewColumnWidth(min: 220, ideal: 250)
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
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: ItemRequestModel.self, inMemory: true)
}
