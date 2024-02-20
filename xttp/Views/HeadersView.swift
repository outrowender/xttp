//
//  HeadersView.swift
//  xttp
//
//  Created by Wender on 19/02/24.
//

import SwiftUI

struct HeadersView: View {
    @State private var address: String = ""

    var body: some View {
        VStack {
            HStack {
                TextField("key", text: $address)
                               .textFieldStyle(PlainTextFieldStyle())
                               .padding(.all, 8)
                               .background(.clear)
                
                TextField("value", text: $address)
                               .textFieldStyle(PlainTextFieldStyle())
                               .padding(.all, 8)
                               .background(.clear)
            }
            
            Button(action: {
                print("add new header")
            }) {
                Label("New header", systemImage: "plus")
            }.padding(8)
        }
    }
}

#Preview {
    HeadersView()
}
