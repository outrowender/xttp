//
//  HeadersView.swift
//  xttp
//
//  Created by Wender on 19/02/24.
//

import SwiftUI

struct HeadersView: View {

    @Binding var model: [HeaderRequestModel]

    var body: some View {
        VStack(alignment: .leading) {
            
            let sortedHeaders = $model.sorted { $0.timestamp.wrappedValue < $1.timestamp.wrappedValue }

            ForEach(sortedHeaders, id: \.id) { header in
                var disabled = false
                
                HStack {
                    
                    TextField("Name", text: header.key)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(.clear)
                        .disabled(header.required.wrappedValue)
                    
                    TextField("Value", text: header.value)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(.clear)
                    
                        Button {
                            if disabled { return }
                            
                            disabled = true
                            self.removeItem(id: header.id)
                        } label: {
                            Image(systemName: "minus.circle.fill")
                        }
                        // TODO: check why button wont disable
                        .disabled(header.required.wrappedValue || disabled)
                        .buttonStyle(.borderless)
                }
            }
            
            HStack {
                Spacer()
                Button {
                    self.addNewItem()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .buttonStyle(.borderless)
            }
        }
    }
}

#Preview {
    HeadersView(model: .constant([
        .init(key: "key", value: "value"),
        .init(key: "key required", required: true, value: "value")
    ]))
}
