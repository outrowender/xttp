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
        
        HStack(spacing: 0) {
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
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
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
                    Spacer()
                }
                
                if viewModel.contentType == 2 {
                    Spacer() // TODO
                }
            }
            .padding(8)
            
            Divider()
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                if viewModel.isLoading {
                    HStack {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                } else if let result = model.lastResult {
                    HStack(spacing: 20) {
                        HStack {
                            Text("\(result.statusCode)")
                                .foregroundStyle(result.statusCodeColored())
                            Text(result.statusCodeNamed())
                        }
                        
                        HStack {
                            Image(systemName: "stopwatch")
                            Text("\(Int((result.time ?? 0) * 1000))ms")
                        }
                        
                        HStack {
                            Image(systemName: "doc")
                            Text("\(result.raw?.count ?? 0)b")
                        }
                    }
                    
                    Divider()
                    
                    ScrollView {
                        Text(result.raw ?? "No content")
                            .font(.system(size: 13))
                            .padding(8)
                    }
                } else {
                    HStack {
                        Text("No response")
                            .font(.title)
                    }
                }
            }
            .frame(width: 300)
            .padding(8)
        }
        .toolbar(.hidden, for: .automatic)
        .ignoresSafeArea()
    }
    
}

#Preview {
    RequestView(model: .constant(.init(name: "req")))
}
