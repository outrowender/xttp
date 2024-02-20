//
//  XttpCore.swift
//  xttp_async
//
//  Created by Wender on 12/02/24.
//

import Foundation

// MARK: Protocol
public protocol XttpCoreProtocol {
    func request(_ type: XttpRequestType, url: String, headers: [String: String]?, cachePolicy: URLRequest.CachePolicy?) async throws -> XttpResponse<String>
}

// MARK: Implementation
public struct XttpCore: XttpCoreProtocol {
    private let session = URLSession.shared
    
    public init(){}
    
    public func request(_ type: XttpRequestType,
                        url: String,
                        headers: [String: String]? = [:],
                        cachePolicy: URLRequest.CachePolicy? = .reloadIgnoringLocalAndRemoteCacheData) async throws -> XttpResponse<String> {
        
        guard let url = URL(string: url) else {
            throw XttpServiceError.invalidUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.rawValue
        
        if let cachePolicy = cachePolicy {
            request.cachePolicy = cachePolicy
        }
        
        headers?.forEach {
            request.setValue($1, forHTTPHeaderField: $0)
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw XttpServiceError.invalidResponse
        }
        
        let rawResponse = String(decoding: data, as: UTF8.self)
        let decoder = JSONDecoder()
        
        let bodyResponse = try? decoder.decode(String.self, from: data)
        
        //         let bodyResponseData = try? JSONSerialization.data(withJSONObject: bodyResponse, options: .prettyPrinted),
        //           let bodyResponseString = String(data: bodyResponseData, encoding: .utf8) {
        //        }
        
        return XttpResponse<String>(statusCode: httpResponse.statusCode, raw: rawResponse, content: bodyResponse)
    }
}

public struct XttpResponse<T> {
    public let statusCode: Int
    public let raw: String?
    public let content: T?
}

public enum XttpRequestType: String {
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
