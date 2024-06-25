//
//  APIListSectionConverter.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/25/24.
//

import Foundation


final class APIListSectionConverter {
    func createSections(models: [RequestComponentModel]) -> [SectionModelType] {
        return [
            createAPIRequestSections(with: models)
        ].flatMap { $0 }
    }
}

extension APIListSectionConverter {
    private func createAPIRequestSections(with models: [RequestComponentModel]) -> [SectionModelType] {
        let components = models.map { model in
            RequestButtonComponent(identifier: model.identifier,
                                   buttonTitle: model.apiType.rawValue,
                                   response: model.response)
        }
        
        let section = SectionModel(identifier: "api_request_section",
                                   collectionLayout: createAPIRequestSectionLayout(),
                                   itemModels: components)
        
        return [section]
    }
    
    private func createAPIRequestSectionLayout() -> APIRequestSectionModel {
        let section = APIRequestSectionModel(itemStrategy: .item(widthDimension: .fractionalWidth(1.0),
                                                                 heightDimension: .estimated(50)),
                                             groupStrategy: .group(widthDimension: .fractionalWidth(1.0),
                                                                   heightDimension: .estimated(50)),
                                             sectionInset: .with(top: 8, bottom: 8),
                                             scrollBehavior: .none)
        
        return section
    }
}
