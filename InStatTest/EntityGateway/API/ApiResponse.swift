//
//  ApiResponse.swift
//  InStatTest
//
//  Created by andy on 30.06.2022.
//

import Foundation

struct NetworkRequestError: Error {
    let error: Error?

    var localizedDescription: String {
        return error?.localizedDescription ?? "Network request error - no other information"
    }
}

struct ApiError: Error {
    let data: Data?
    let httpUrlResponse: HTTPURLResponse
}

struct ApiParseError: Error {
    static let code = 999

    let error: Error
    let httpUrlResponse: HTTPURLResponse
    let data: Data?

    var localizedDescription: String {
        print(error)
        return error.localizedDescription
    }
}

struct ApiResponse<T: Decodable> {
    let entity: T
    let httpUrlResponse: HTTPURLResponse
    let data: Data?

    init(data: Data?, httpUrlResponse: HTTPURLResponse) throws {
        do {
            self.entity = try JSONDecoder().decode(T.self, from: data ?? Data())
            self.httpUrlResponse = httpUrlResponse
            self.data = data
        } catch {
            throw ApiParseError(error: error, httpUrlResponse: httpUrlResponse, data: data)
        }
    }
}
