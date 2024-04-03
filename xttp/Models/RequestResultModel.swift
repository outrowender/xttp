//
//  RequestResultModel.swift
//  xttp
//
//  Created by Wender on 28/02/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class RequestResultModel {
    var id: UUID
    var statusCode: Int
    var errorCode: String?
    var raw: String?
    var time: TimeInterval?
    
    init(
        id: UUID = UUID(),
        statusCode: Int,
        errorCode: String? = nil,
        raw: String? = nil,
        time: TimeInterval? = nil) {
            self.id = id
            self.statusCode = statusCode
            self.errorCode = errorCode
            self.raw = raw
            self.time = time
        }
    
    func statusCodeColored() -> Color {
        switch self.statusCode {
        case 100...199: // informational response
            return .blue
        case 200...299: // successful
            return .green
        case 300...399: // redirection
            return .yellow
        case 400...499: // client error
            return .orange
        default: // server error
            return .red
        }
    }
    
    func statusCodeNamed() -> String {
        let values = [
            100: "Continue",
            200: "OK",
            201: "Created",
            202: "Accepted",
            204: "No content",
            302: "Found",
            400: "Bad request",
            401: "Unauthorized",
            402: "Payment required",
            403: "Forbidden",
            404: "Not found",
            405: "Method not allowed",
            408: "Request timeout",
            409: "Conflict",
            410: "Gone",
            415: "Unsupported media type",
            429: "Too many requests",
            444: "No Response",
            500: "Internal server error",
            501: "Not implemented",
            502: "Bad gateway",
            503: "Service unavailable"
        ]
        
        return values[statusCode] ?? "Code"
    }
}

public enum StatusRequestModel: Int {
    
    case ok = 200
    case created = 201
    case accepted = 202
    case noContent = 204
    case found = 302
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case methodNotAllowed = 405
    case requestTimeout = 408
    case conflict = 409
    case gone = 410
    case unsupportedMediaType = 415
    case tooManyRequests = 429
    case noResponse = 444
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailable = 503
    
    static func colored(_ rawValue: Int) -> Color {
        
        switch rawValue {
        case 100...199: // informational response
            return .blue
        case 200...299: // successful
            return .blue
        case 300...399: // redirection
            return .blue
        case 400...499: // client error
            return .blue
        default: // server error
            return .red
        }
    }
}
