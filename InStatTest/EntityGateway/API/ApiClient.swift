//
//  ApiClient.swift
//  InStatTest
//
//  Created by andy on 30.06.2022.
//

import Foundation

protocol ApiRequest {
    var urlRequest: URLRequest { get }
}

protocol ApiClient {
    func execute<T>(request: ApiRequest, completionHandler: @escaping (_ result: Result<ApiResponse<T>>) -> Void)
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }

class ApiClientImplementation: ApiClient {
    let urlSession: URLSessionProtocol

    init(urlSessionConfiguration: URLSessionConfiguration, delegateQueue: OperationQueue) {
        urlSession = URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: delegateQueue)
    }

    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }

    func execute<T>(request: ApiRequest, completionHandler: @escaping (Result<ApiResponse<T>>) -> Void) {
        urlSession.dataTask(with: request.urlRequest) { (data, response, error) in
            #if DEBUG
            print("CALL request", request.urlRequest)
            #endif

            guard let httpUrlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(NetworkRequestError(error: error)))
                return
            }

            let successRange = 200...299
            guard successRange.contains(httpUrlResponse.statusCode) else {
                completionHandler(.failure(ApiError(data: data, httpUrlResponse: httpUrlResponse)))
                return
            }

            do {
                let response = try ApiResponse<T>(data: data, httpUrlResponse: httpUrlResponse)
                completionHandler(.success(response))
            } catch {
                completionHandler(.failure(error))
            }
        }.resume()
    }
}
