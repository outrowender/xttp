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
    func addNewItem() {
        let newItem = HeaderRequestModel()
        withAnimation {
            self.model.append(newItem)
        }
    }
    
    func removeItem(id: UUID) {
        withAnimation {
            self.model.removeAll { $0.id == id }
        }
    }
}
