//
//  APIListViewModel.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/25/24.
//

import Foundation
import Combine

enum APIListType: String, CaseIterable {
    case fetchUsers
    case fetchUser
    case updateUser
    case deleteUser
}

struct RequestComponentModel {
    let identifier: String
    let response: String
    let apiType: APIListType
}

final class APIListViewModel {
    private let sectionConverter = APIListSectionConverter()
    private let repository = APIListRepository()
    
    private var mockModel: [RequestComponentModel] = []
    
    private let requestComponentSubject = CurrentValueSubject<[SectionModelType], Never>([])
    var requestComponentsPublisher: AnyPublisher<[SectionModelType], Never> {
        requestComponentSubject.eraseToAnyPublisher()
    }
    
    init() {
        mockModel = APIListType.allCases.map { RequestComponentModel(identifier: UUID().uuidString,
                                                                     response: "",
                                                                     apiType: $0) }
        
        let sections = sectionConverter.createSections(models: mockModel)
        requestComponentSubject.send(sections)
    }
    
    func requestAPI(with identifier: String) {
        guard let model = mockModel.first(where: { $0.identifier == identifier }) else {
            print("item not found.")
            return
        }
        
        switch model.apiType {
        case .fetchUser:
            repository.fetchUsers()
            print("TODO: fetchUser API Request")
        case .fetchUsers:
            print("TODO: fetchUsers API Request")
        case .updateUser:
            print("TODO: updateUser API Request")
        case .deleteUser:
            print("TODO: deleteUser API Request")
        }
    }
}
