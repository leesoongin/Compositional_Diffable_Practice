//
//  SectionModelType+Hashable.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/17/24.
//

import Foundation

struct SectionItem: Hashable {
    let sectionModel: SectionModelType
    var differenceIdentifier: String { sectionModel.identifier }
    
    static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
        lhs.sectionModel.hashValue == rhs.sectionModel.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(sectionModel.hashValue)
    }
}
