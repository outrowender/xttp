//
//  RequestView.swift
//  xttp
//
//  Created by Wender on 11/02/24.
//

import SwiftUI

struct RequestView: View {
    @Bindable var model: ItemRequestModel
    
    @State private var address: String = ""
    @State private var bodyContent: String = ""
    @State private var contentType = 0
    @State private var methodType: XttpRequestType = .get
    @State private var result: String = ""
    
    init(_ model: ItemRequestModel) {
        self.model = model
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Picker(selection: $model.type, content: {
                    Text("GET").tag(XttpRequestType.get.rawValue)
                    Text("POST").tag(XttpRequestType.post.rawValue)
                    Text("PUT").tag(XttpRequestType.put.rawValue)
                    Text("PATCH").tag(XttpRequestType.patch.rawValue)
                    Text("DELETE").tag(XttpRequestType.delete.rawValue)
                    Text("OPTIONS").tag(XttpRequestType.options.rawValue)
                    Text("HEAD").tag(XttpRequestType.head.rawValue)
                }, label: {})
                .pickerStyle(.menu)
                .frame(maxWidth: 100)
                
                TextField("URL", text: $model.url)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: runItem) {
                    Label("Run", systemImage: "play.fill")
                }
                
            }
            .padding(.bottom, 8)
            .padding(.horizontal, 16)
            
            HStack {
                VStack {
                    
                    Picker(selection: $contentType, content: {
                        Text("Headers").tag(0)
                        Text("Body").tag(1)
                    }, label: {})
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 16)
                    
                    if contentType == 0 {
                        HeadersView()
                        Spacer()
                    }
                    
                    if contentType == 1 {
                        TextEditor(text: $model.body)
                            .font(.system(size: 13))
                            .padding(.top, 3)
                    }

                }
                
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
    
    func runItem() {
        Task {
            
            do {
                let request = try await XttpCore().request(
                    XttpRequestType(rawValue: model.type)!,
                    url: model.url)
                
                model.lastResult = request.raw ?? ""
                print(model.lastResult ?? "nothing")
            } catch (let e) {
                print(e)
            }

        }
        
    }
}

#Preview {
    RequestView(.init(name: "new request", url: "https://google.com"))
}
