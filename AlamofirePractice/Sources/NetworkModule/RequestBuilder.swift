//
//  RequestBuilder.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/25/24.
//

import Foundation
import Combine
import Alamofire


public enum NetworkError: Int, Error {
    case success = 200
    case noPermission = 400
    case noPermissionSecond = 401
}

// API에서 내려주는 데이터는 data외에 code와 version등 추가로 내려오는게 있어 이걸 분리 하기 위한 wrapper
// 이를 decode(from:)에서 한번 정제하여 전달한다
public struct ResponseWrapper<ResponseType: Decodable>: Decodable {
    public let code: Int
    public let timestamp: String?
    public let data: ResponseType?
    public let message: String?
}

public struct EmptyResponseType: Decodable { }

public protocol RequestBuilder: CoreRequestBuilder {
    
}

// MARK: - request
extension RequestBuilder {
    public func request(debug: Bool = false) -> AnyPublisher<ResponseType, Error> {
        return Deferred {
            Just(Void()).eraseToAnyPublisher()
                .flatMap {
                    self.defaultRequest(debug: debug)
                }
        }
        .catch { error in
            //TODO: ERROR Handle
            Fail(error: error).eraseToAnyPublisher()
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }

    public func defaultDecode(from data: Data) throws -> ResponseType {
        if let decoded = try? jsonDecoder().decode(ResponseWrapper<EmptyResponseType>.self, from: data) {
            if let error = NetworkError(rawValue: decoded.code) {
                //TODO: Error Handle
                throw error
            }
        }

        return try decode(from: data)
    }

    public func decode(from data: Data) throws -> ResponseType {
        let decoded = try jsonDecoder().decode(ResponseWrapper<ResponseType>.self, from: data)

        if let data = decoded.data {
            return data
        } else {
            throw CommonNetworkError.invalidResponse
        }
    }
}

// MARK: - mockRequest
extension RequestBuilder {
    public func mockRequest(from string: String) -> AnyPublisher<ResponseType, Error> {
        defaultMockRequest(from: string)
            .catch { error in
                Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
