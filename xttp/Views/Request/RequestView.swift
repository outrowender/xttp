//
//  RequestView.swift
//  xttp
//
//  Created by Wender on 11/02/24.
//

import SwiftUI

struct RequestView: View {
    
    @State private var viewModel: ViewModel = ViewModel()
    @Binding var model: ItemRequestModel
    
    var body: some View {
        
        HStack {
            VStack {
                
                HStack {
                    
                    Picker(selection: $model.type, content: {
                        ForEach(XttpRequestType.allCases, id: \.rawValue) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }, label: {})
                    .pickerStyle(.menu)
                    .frame(maxWidth: 100)
                    
                    TextField("URL", text: $model.url)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        viewModel.runItem(model: model)
                    }) {
                        Label("Send", systemImage: "paperplane.fill")
                    }
                    
                }
                .contentMargins(16)
                
                Picker(selection: $viewModel.contentType, content: {
                    Text("Body").tag(0)
                    Text("Headers").tag(1)
                    Text("Query").tag(2)
                }, label: {})
                .pickerStyle(.segmented)
                
                if viewModel.contentType == 0 {
                    TextEditor(text: $model.body)
                        .font(.system(size: 13))
                        .padding(.top, 8)
                }
                
                if viewModel.contentType == 1 {
                    HeadersView(model: model)
                        .padding(.horizontal, 8)
                    Spacer()
                }
                
                if viewModel.contentType == 2 {
                    Spacer() // TODO
                }
            }
            .padding(8)
            
            Divider()
                .ignoresSafeArea()
            
            VStack {
                if let result = viewModel.lastResult {
                    
                    Text("Status code")
                    Text("\(result.statusCode)")
                    
                    Text("Time")
                    Text("\(Int((result.time ?? 0) * 1000)) ms")
                    
                    Text("Size")
                    Text("\(result.raw?.count ?? 0) b")
                    
                    ScrollView {
                        Text(result.raw ?? "No content")
                            .font(.system(size: 13))
                            .padding(8)
                    }
                }
                
            }
        }
        .toolbar(.hidden, for: .automatic)
        .ignoresSafeArea()
    }
    
}

#Preview {
    RequestView(model: .constant(.init(name: "req")))
}
