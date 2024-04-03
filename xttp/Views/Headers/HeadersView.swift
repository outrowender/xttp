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
        VStack(alignment: .leading) {
            
            
            
            ForEach($viewModel.model.headers.sorted { $0.timestamp.wrappedValue < $1.timestamp.wrappedValue }) { header in
                HStack {
                    TextField("Name", text: header.key)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(.clear)
                        .disabled(header.required.wrappedValue)
                    
                    TextField("Value", text: header.value)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(.clear)
                    
                        Button {
                            viewModel.removeItem(id: header.id)
                        } label: {
                            Image(systemName: "minus.circle.fill")
                        }
                        .disabled(header.required.wrappedValue)
                        .buttonStyle(.borderless)
                    
                }
            }
            
            HStack {
                Spacer()
                Button {
                    viewModel.addNewItem()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .buttonStyle(.borderless)
            }
        }
    }
}

#Preview {
    HeadersView(model: .init(name: "new request", url: "https://google.com"))
}
