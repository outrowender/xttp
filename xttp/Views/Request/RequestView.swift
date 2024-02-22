//
//  RequestView.swift
//  xttp
//
//  Created by Wender on 11/02/24.
//

import SwiftUI

struct RequestView: View {
    
    @State private var viewModel: ViewModel
    
    init(_ requestModel: ItemRequestModel) {
        viewModel = ViewModel(model: requestModel)
    }
    
    var body: some View {
        
        HStack {
            VStack {
                
                HStack {
                    
                    Picker(selection: $viewModel.model.type, content: {
                        ForEach(XttpRequestType.allCases, id: \.rawValue) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }, label: {})
                    .pickerStyle(.menu)
                    .frame(maxWidth: 100)
                    
                    TextField("URL", text: $viewModel.model.url)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: viewModel.runItem) {
                        Label("Run", systemImage: "play.fill")
                    }
                    
                }
                .padding(.bottom, 8)
                .padding(.horizontal, 16)
                
                Picker(selection: $viewModel.contentType, content: {
                    Text("Headers").tag(0)
                    Text("Body").tag(1)
                }, label: {})
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                
                if viewModel.contentType == 0 {
                    HeadersView(model: viewModel.model)
                        .padding(.horizontal, 8)
                    Spacer()
                }
                
                if viewModel.contentType == 1 {
                    TextEditor(text: $viewModel.model.body)
                        .font(.system(size: 13))
                        .padding(.top, 8)
                        .padding(.leading, 16)
                }
                
            }
            
            VStack {
                ScrollView {
                    if let result = viewModel.model.lastResult {
                        
                        Text(result)
                            .font(.system(size: 13))
                            .padding(.top, 3)
                    }
                }
            }
        }
        .toolbar(.hidden, for: .automatic)
    }
    
}

#Preview {
    RequestView(.init(name: "new request", url: "https://google.com"))
}
