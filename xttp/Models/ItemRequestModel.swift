//
//  Item.swift
//  xttp
//
//  Created by Wender on 11/02/24.
//

import Foundation
import SwiftData

@Model
final class ItemRequestModel {
    var timestamp: Date
    var name: String
    var url: String
    var type: String
    var headers: [HeaderRequestModel]
    var body: String
    var lastResult: String?
    
    init(timestamp: Date = Date(),
         name: String,
         url: String = "",
         type: String = VerbRequestModel.get.rawValue,
         headers: [HeaderRequestModel] = [],
         body: String = "",
         lastResult: String? = nil) {
        self.timestamp = timestamp
        self.name = name
        self.url = url
        self.type = type
        self.headers = headers
        self.body = body
        self.lastResult = lastResult
    }
}

public enum VerbRequestModel: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case options = "OPTIONS"
    case head = "HEAD"
}
