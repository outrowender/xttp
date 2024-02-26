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
    
    @EnvironmentObject var appModel: AppModel
    
    init(modelContext: ModelContext) {
        viewModel = ViewModel(modelContext: modelContext)
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            VStack {
                
                HStack { // TODO: fix this alignment
                    Spacer()
                    
                    Button {
                            
                    } label: {
                        Image(systemName: "play.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 15)
                            .padding(5)
                    }
                    .buttonStyle(.accessoryBar)
                    .padding(.horizontal, 10)
                    
                }
                
                List(selection: $viewModel.selectedItem) {
                    
                    Section(header: Text("My requests")) {
                        
                        ForEach(Array(viewModel.items.enumerated()), id: \.element) { index, item in
                            
                            HStack {
                                Circle()
                                    .fill(VerbRequestModel.colored(item.type))
                                    .frame(width: 8, height: 8)
                                
                                Text(item.name)
                                
                                Spacer()
                            }
                            .tag(index)
                            .contextMenu {
                                Button("Rename") {
                                    viewModel.editItem(item)
                                }
                                
                                Button("Delete") {
                                    viewModel.deleteItem(item)
                                }
                            }
                        }
                    }
                    
                    
                    Button(action: viewModel.addItem) {
                        Label("New request", systemImage: "sparkle")
                    }
                    
                }
                .listStyle(SidebarListStyle())
            }
            .background(GlassEffect().ignoresSafeArea())
            .frame(width: 200)
            
            Divider()
                .ignoresSafeArea()
            
            if viewModel.items.count > 0 {
                RequestView(model: .constant(viewModel.items[viewModel.selectedItem]))
            } else {
                Spacer()
            }
        }
        .listen(for: $appModel.addNewAction, action: {
            viewModel.addItem()
        })
        .alert("New name", isPresented: $viewModel.showingAlert) {
            TextField("Name", text: $viewModel.editingItem.name)
            Button("OK") { }
        }
    }
    
}

#Preview {
    HomeView(
        modelContext: .init(
            try! .init(
                for: ItemRequestModel.self,
                configurations: .init(isStoredInMemoryOnly: true)
            )
        )
    ).frame(width: 500)
}
