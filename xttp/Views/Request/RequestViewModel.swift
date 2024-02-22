//
//  RequestViewModel.swift
//  xttp
//
//  Created by Wender on 22/02/24.
//

import Foundation
import SwiftUI

extension RequestView {
    @Observable
    class ViewModel {
        var address: String
        var bodyContent: String
        var contentType = 0
        var methodType: XttpRequestType
        var result: String
        
        var model: ItemRequestModel
        
        init(model: ItemRequestModel) {
            self.model = model
            
            address = model.url
            bodyContent = model.body
            result = model.lastResult ?? ""
            methodType = XttpRequestType(rawValue: model.type) ?? .get
        }
        
        func runItem() {
            Task {
                do {
                    let request = try await HttpCore().request(
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
}
