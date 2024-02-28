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
        
        var lastResult: XttpResponse<String>?
        
        func runItem(model: ItemRequestModel) {
            Task {
                let request = await HttpCore().request(
                    XttpRequestType(rawValue: model.type)!,
                    url: model.url)
                
                model.lastResult = request.raw ?? ""
                
                lastResult = request
                
            }
            
        }
        
    }
}
