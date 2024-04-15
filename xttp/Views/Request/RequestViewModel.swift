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
        var contentType = 0
        var isLoading = false
        
        func runItem(model: ItemRequestModel) {
            Task {
                isLoading = true
                
                // TODO: move this somewhere
                var headers: [String: String] = [:]
                for header in model.headers {
                    if header.key.isEmpty { continue }
                    headers[header.key] = header.value
                }
                
                let body = Data(model.body.utf8)
                
                let request = await HttpCore().request(
                    XttpRequestType(rawValue: model.type)!,
                    url: model.url,
                    headers: headers,
                    body: body
                )
                
                let result = RequestResultModel(statusCode: request.statusCode,
                                                errorCode: request.errorCode, 
                                                raw: request.raw,
                                                time: request.time)
                
                Task.detached { [weak self] in
                    model.lastResult = result
                    self?.isLoading = false
                }
            }
        }
        
        func cleanItem(model: ItemRequestModel) {
            isLoading = true
            model.lastResult = nil
            isLoading = false
        }
    }
}
