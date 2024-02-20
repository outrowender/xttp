//
//  HeadersView.swift
//  xttp
//
//  Created by Wender on 19/02/24.
//

import SwiftUI

struct HeadersView: View {
    @Bindable var model: ItemRequestModel
    @State private var address: String = ""

    var body: some View {
        VStack {
//            List {
                ForEach($model.headers) { header in
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
                            model.headers.removeAll { $0.id == header.id }
                        } label: {
                            Image(systemName: "minus.circle.fill")
                        }.buttonStyle(.borderless)
                    }
                }
                
                Button(action: {
                    withAnimation {
                        let newItem = HeaderRequestModel()
                        model.headers.append(newItem)
                    }
                }) {
                    Label("New header", systemImage: "plus")
                }.padding(8)
//            }
        }
    }
}

#Preview {
    HeadersView(model: .init(name: "new request", url: "https://google.com"))
}
