//
//  HttpCore.swift
//  xttp
//
//  Created by Wender on 12/02/24.
//

import Foundation

// MARK: Protocol
public protocol XttpCoreProtocol {
    func request(_ type: XttpRequestType, url: String, headers: [String: String]?, cachePolicy: URLRequest.CachePolicy?) async throws -> XttpResponse
}

// MARK: Implementation
public struct HttpCore: XttpCoreProtocol {
    private let session = URLSession.shared
    
    public init(){}
    
    public func request(_ type: XttpRequestType,
                        url: String,
                        headers: [String: String]? = [:],
                        cachePolicy: URLRequest.CachePolicy? = .reloadIgnoringLocalAndRemoteCacheData) async -> XttpResponse {
        
        guard let url = URL(string: url) else {
            return XttpResponse(statusCode: 0, raw: nil, time: nil, errorCode: "Invalid URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        
        headers?.forEach {
            if !$0.isEmpty {
                request.setValue($1, forHTTPHeaderField: $0)
            }
        }
        
        let snapshot = Date()
        
        guard let (data, response) = try? await session.data(for: request) else {
            return XttpResponse(statusCode: 0, raw: nil, time: nil, errorCode: "Request failed")
        }
        
        let timeDifference = Date().timeIntervalSince(snapshot)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return XttpResponse(statusCode: 0, raw: nil, time: timeDifference, errorCode: "Invalid response")
        }
        
        let rawResponse = String(decoding: data, as: UTF8.self)
        // TODO: check json response
//        let decoder = JSONDecoder()
        
//        guard let bodyResponse = try? decoder.decode(String.self, from: data) else {
//            return XttpResponse<String>(statusCode: httpResponse.statusCode, raw: rawResponse, content: nil, time: timeDifference, errorCode: "Can't parse to JSON") // TODO: check this for false positive JSON responses
//        }
        return XttpResponse(statusCode: httpResponse.statusCode, raw: rawResponse, time: timeDifference)
    }
}

public struct XttpResponse {
    public let statusCode: Int
    public let errorCode: String?
    public let raw: String?
    public let time: TimeInterval?
    
    init(statusCode: Int, 
         raw: String?,
         time: TimeInterval? = nil,
         errorCode: String? = nil) {
        self.statusCode = statusCode
        self.errorCode = errorCode
        self.raw = raw
        self.time = time
    }
}

public enum XttpRequestType: String, CaseIterable {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case options = "OPTIONS"
    case head = "HEAD"
}

public enum XttpServiceError: Error {
    case invalidUrl
    case invalidResponse
    case invalidConversion
}
