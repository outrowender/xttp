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
    
//    init() {
//        viewModel = ViewModel()
//    }
    
    var body: some View {
        
        HStack {
            List {
                
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
                        Label("Run", systemImage: "play.fill")
                    }
                    
                }
                .contentMargins(16)
                
                Picker(selection: $viewModel.contentType, content: {
                    Text("Headers").tag(0)
                    Text("Body").tag(1)
                }, label: {})
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                
                if viewModel.contentType == 0 {
                    HeadersView(model: model)
                        .padding(.horizontal, 8)
                    Spacer()
                }
                
                if viewModel.contentType == 1 {
                    TextEditor(text: $model.body)
                        .font(.system(size: 13))
                        .padding(.top, 8)
                        .padding(.leading, 16)
                }
                
            }
            
            Rectangle()
                .fill(.black)
                .ignoresSafeArea()
                .frame(width: 1)
            
            VStack {
                ScrollView {
                    if let result = model.lastResult {
                        
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

//#Preview {
//    RequestView(model: .ini)
//}
