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
                List(selection: $viewModel.selectedItem) {
                    Section(header: Text("My requests")) {
                        ForEach(Array(viewModel.items.enumerated()), id: \.element.id) { index, item in
                            HStack { // TODO: use grid instead
                                Text(item.type.prefix(4))
                                    .font(.system(size: 8))
                                    .foregroundStyle(VerbRequestModel.colored(item.type))
                                    .frame(width: 26)
                                    .padding(.all, 2)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(.separator, lineWidth: 1)
                                    )
                                Text(item.name)
                                Spacer()
                                
                            }
                            .contextMenu {
                                Button {
                                    viewModel.renameSelectedItem(item: index)
                                } label: {
                                    Text("Rename")
                                }
                                
                                Button {
                                    viewModel.deleteSelectedItem(item: index)
                                } label: {
                                    Text("Delete")
                                }
                            }
                            .tag(index)
                        }
                    }
                }
                .listStyle(SidebarListStyle())
            }
            .background(
                GlassEffect()
                    .ignoresSafeArea()
            )
            .frame(width: 200)
            .contextMenu {
                Button {
                    viewModel.addItem()
                } label: {
                    Text("New request")
                }
            }
            
            Divider()
                .ignoresSafeArea()
            
            if viewModel.items.count > 0 {
                RequestView(model: .constant(viewModel.items[viewModel.selectedItem]))
            } else {
                Spacer()
            }
        }
        .listen(for: $appModel.addNewAction, action: { _, _ in
            viewModel.addItem()
        })
        .listen(for: $appModel.renameAction, action: { _, _ in
            viewModel.renameSelectedItem()
        })
        .listen(for: $appModel.deleteAction, action: { _, _ in
            viewModel.deleteSelectedItem()
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
