//
//  APIListRepository.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/25/24.
//

import Foundation
import Alamofire
import Combine

final class APIListRepository {
    var cancellables = Set<AnyCancellable>()
    
    func fetchUsers() {
        UserFetchRequestBuilder().request(debug: true)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("::: finished")
                case .failure(let error):
                    print("::: error occur > \(error)")
                }
            } receiveValue: { value in
                print("::: value > \(value)")
            }
            .store(in: &cancellables)
    }
    
}


class UserFetchRequestBuilder: RequestBuilder {
    typealias ResponseType = EmptyResponseType
    
    var baseURL: String = "https://reqres.in/api"
    var path: String = "/users"
    var method: HTTPMethod = .get
}
