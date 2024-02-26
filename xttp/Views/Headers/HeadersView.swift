//
//  HeadersView.swift
//  xttp
//
//  Created by Wender on 19/02/24.
//

import SwiftUI

struct HeadersView: View {
    
    @State private var viewModel: ViewModel
    
    init(model: ItemRequestModel) {
        self.viewModel = ViewModel(model: model)
    }
    
    var body: some View {
        VStack {
            ForEach($viewModel.model.headers) { header in
                HStack {
                    TextField("key", text: header.key)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.all, 8)
                        .background(.clear)
                    
                    TextField("value", text: header.value)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.all, 8)
                        .background(.clear)
                    
                    Button {
                        viewModel.removeItem(id: header.id)
                    } label: {
                        Image(systemName: "minus.circle.fill")
                    }.buttonStyle(.borderless)
                }
            }
            
            Button(action: viewModel.addNewItem) {
                Label("New header", systemImage: "plus")
            }.padding(8)
        }
    }
}

#Preview {
    HeadersView(model: .init(name: "new request", url: "https://google.com"))
}
