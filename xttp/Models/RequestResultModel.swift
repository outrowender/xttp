//
//  RequestResultModel.swift
//  xttp
//
//  Created by Wender on 28/02/24.
//

import Foundation
import SwiftData

@Model
class RequestResultModel {
    var statusCode: Int
    var errorCode: String?
    var raw: String?
    var time: TimeInterval?
    
    init(statusCode: Int, 
         errorCode: String? = nil,
         raw: String? = nil,
         time: TimeInterval? = nil) {
        self.statusCode = statusCode
        self.errorCode = errorCode
        self.raw = raw
        self.time = time
    }
}
