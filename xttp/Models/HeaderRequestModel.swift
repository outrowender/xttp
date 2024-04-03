//
//  HeaderRequestModel.swift
//  xttp
//
//  Created by Wender on 19/02/24.
//

import Foundation
import SwiftData

@Model
class HeaderRequestModel {
    var id: UUID
    var timestamp: Date
    var key: String
    var required: Bool
    var value: String
    
    init(
        id: UUID = UUID(),
        timestamp: Date = .now,
        key: String = "",
        required: Bool = false,
        value: String = ""
    ) {
        self.id = id
        self.timestamp = timestamp
        self.key = key
        self.required = required
        self.value = value
    }
}
