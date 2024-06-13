//
//  SectionModel.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/13/24.
//

import Foundation

public struct SectionModel: SectionModelType {
    public let identifier: String
    public let header: ItemModelType?
    public let footer: ItemModelType?

    public let itemModels: [ItemModelType]

    public init(identifier: String,
                header: ItemModelType? = nil,
                footer: ItemModelType? = nil,
                itemModels: [ItemModelType]) {
        self.identifier = identifier
        self.header = header
        self.footer = footer
        self.itemModels = itemModels
    }

    public func hash(into hasher: inout Hasher) { }
}
