//
//  Item.swift
//  xttp
//
//  Created by Wender on 11/02/24.
//

import SwiftData
import SwiftUI

@Model
final class ItemRequestModel {
    var timestamp: Date
    var name: String
    var url: String
    var type: String
    var headers: [HeaderRequestModel]
    var body: String
    var lastResult: RequestResultModel?
    
    init(timestamp: Date = Date(),
         name: String,
         url: String = "",
         type: String = VerbRequestModel.get.rawValue,
         headers: [HeaderRequestModel] = [],
         body: String = "",
         lastResult: RequestResultModel? = nil) {
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
    
    static func colored(_ rawValue: String) -> Color {
        let scheme: [VerbRequestModel: Color] = [
            .get: .purple,
            .post: .green,
            .put: .orange,
            .patch: .yellow,
            .delete: .red,
            .options: .blue,
            .head: .blue
        ]
        
        let value = VerbRequestModel(rawValue: rawValue) ?? .get
        
        return scheme[value] ?? .white
    }
}
