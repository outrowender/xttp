//
//  HeadersViewModel.swift
//  xttp
//
//  Created by Wender on 22/02/24.
//

import Foundation
import SwiftUI
import SwiftData

extension HeadersView {
    @Observable
    class ViewModel {
        var model: ItemRequestModel
        var address: String = ""
        
        init(model: ItemRequestModel) {
            self.model = model
        }
        
        func addNewItem() {
            let newItem = HeaderRequestModel()
            withAnimation {
                model.headers.append(newItem)
            }
        }
        
        func removeItem(id: PersistentIdentifier) {
            withAnimation {
                model.headers.removeAll { $0.id == id }
            }
        }
        
    }
}
