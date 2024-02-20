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
    var name: String
    var key: String
    var value: String
    
    init(name: String = .generate(with: 8),
         key: String = "",
         value: String = "") {
        self.name = name
        self.key = key
        self.value = value
    }
}
