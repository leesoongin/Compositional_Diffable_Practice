//
//  ItemModelType+Hashable.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/13/24.
//

import Foundation

struct ListItem: Hashable {
    let itemModel: ItemModelType
    var differenceIdentifier: String { itemModel.identifier }
    
    static func == (lhs: ListItem, rhs: ListItem) -> Bool {
        lhs.itemModel.hashValue == rhs.itemModel.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(itemModel.hashValue)
    }
}
