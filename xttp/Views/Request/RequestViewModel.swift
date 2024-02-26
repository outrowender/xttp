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
        
        func runItem(model: ItemRequestModel) {
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
