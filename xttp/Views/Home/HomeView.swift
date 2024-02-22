//
//  ContentView.swift
//  xttp
//
//  Created by Wender on 11/02/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State private var viewModel: ViewModel
    
    init(modelContext: ModelContext) {
         viewModel = ViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.items) { item in
                    NavigationLink {
                        RequestView(item)
                    } label: {
                        HStack(alignment: .center) {
                            Circle()
                                .fill(VerbRequestModel(rawValue: item.type)?.colored() ?? .white) // TODO: this needs to improve
                                .frame(width: 8, height: 8)
                            Text(item.name)
                        }
                        .contextMenu {
                            Button("Rename") {
                                viewModel.editingItem = item
                                viewModel.showingAlert = true
                            }
                            
                            Button("Delete") {
                                viewModel.deleteItem(item: item)
                            }
                        }
                    }
                }
                
                Button(action: viewModel.addItem) {
                    Label("New request", systemImage: "sparkle")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationSplitViewColumnWidth(min: 220, ideal: 250)
            .alert("New name", isPresented: $viewModel.showingAlert) {
                TextField("Name", text: $viewModel.editingItem.name)
                Button("OK") { }
            }
        }
    }
    
}

// TODO: how to fix previews? Maybe mocked models for empty inits
//#Preview {
//    HomeView()
//        .modelContainer(for: ItemRequestModel.self, inMemory: true)
//}
