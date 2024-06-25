//
//  APIRequestSectionModel.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/25/24.
//

import UIKit

struct APIRequestSectionModel: CompositionalLayoutModelType {
    var itemStrategy: SizeStrategy
    var groupStrategy: SizeStrategy
    
    var headerStrategy: SizeStrategy?
    var footerStrategy: SizeStrategy?
    
    var groupSpacing: CGFloat
    var sectionInset: NSDirectionalEdgeInsets
    
    var scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
    
    init(itemStrategy: SizeStrategy,
         groupStrategy: SizeStrategy,
         headerStrategy: SizeStrategy? = nil,
         footerStrategy: SizeStrategy? = nil,
         groupSpacing: CGFloat = 0,
         sectionInset: NSDirectionalEdgeInsets = .init(vertical: 0, horizontal: 0),
         scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior) {
        self.itemStrategy = itemStrategy
        self.groupStrategy = groupStrategy
        self.headerStrategy = headerStrategy
        self.footerStrategy = footerStrategy
        self.groupSpacing = groupSpacing
        self.sectionInset = sectionInset
        self.scrollBehavior = scrollBehavior
    }
}
