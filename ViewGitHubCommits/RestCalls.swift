//
//  RestCalls.swift
//  ViewGitHubCommits
//
//  Created by Jeff Pape on 11/3/19.
//  Copyright © 2019 Pape Software. All rights reserved.
//

import Foundation

class RestCalls {
    private enum HTTPMethod: String {
        case create = "post"
        case read = "get"
        case update = "put"
        case delete = "delete"
        case head = "head"
        case patch = "patch"
    }
    
    static func create(
        from url: String,
        headers: [String: String],
        urlParameters: [String: String],
        body: Data?,
        timeout: TimeInterval,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        executeRequest(for: url, httpMethod: .create, headers: headers,
                       urlParameters: urlParameters, body: body, timeout: timeout,
                       completion: completion)
    }
    
    static func read(
        from url: String,
        headers: [String: String],
        urlParameters: [String: String],
        timeout: TimeInterval,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        executeRequest(for: url, httpMethod: .read, headers: headers,
                       urlParameters: urlParameters, timeout: timeout,
                       completion: completion)
    }

    static private func executeRequest(
        for urlString: String,
        httpMethod: HTTPMethod,
        headers: [String: String],
        urlParameters: [String: String]?,
        body: Data? = nil,
        timeout: TimeInterval,
        completion: @escaping (Data?, URLResponse?, Error?) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            debugPrint("unable to convert \(urlString) to url object")
            completion(nil, nil, nil)
            return
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if urlParameters?.count ?? 0 != 0 {
            components?.queryItems = urlParameters?.compactMap {URLQueryItem(name: $0.0, value: $0.1)}
        }
        guard let requestURL = components?.url else {
            debugPrint("url is nil")
            completion(nil, nil, nil)
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        request.timeoutInterval = timeout
        debugPrint("\t\(httpMethod.rawValue)\n\t\(request.allHTTPHeaderFields ?? [:])")
        let dataTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            completion(data, response, error)
        }
        
        dataTask.resume()
    }
}
