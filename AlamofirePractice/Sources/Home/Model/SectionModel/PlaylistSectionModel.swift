//
//  PlaylistSectionModel.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/12/24.
//

import UIKit

struct PlaylistSectionModel: CompositionalLayoutModelType {
    var itemStrategy: SizeStrategy
    var groupStrategy: SizeStrategy
    
    var headerStrategy: SizeStrategy?
    var footerStrategy: SizeStrategy?
    
    var groupSpacing: CGFloat
    var sectionInset: NSDirectionalEdgeInsets
    
    var scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
    
    init(itemStrategy: SizeStrategy,
         groupStrategy: SizeStrategy,
         headerStrategy: SizeStrategy?,
         footerStrategy: SizeStrategy?,
         groupSpacing: CGFloat,
         sectionInset: NSDirectionalEdgeInsets,
         scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior) {
        self.itemStrategy = itemStrategy
        self.groupStrategy = groupStrategy
        self.headerStrategy = headerStrategy
        self.footerStrategy = footerStrategy
        self.groupSpacing = groupSpacing
        self.sectionInset = sectionInset
        self.scrollBehavior = scrollBehavior
    }
    
    // 이건 어뎁터에서 호출?하는게? 나을듯?
    func createLayoutSection() -> NSCollectionLayoutSection {
        
//        let item = NSCollectionLayoutItem(layoutSize: self.itemSize)
//        
//        // group
//        let group = NSCollectionLayoutGroup.vertical(layoutSize: self.groupSize, subitems: [item])
//        
//        
//        // section
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = 16 // paging 할때에는 group spacing 이 필요함
//        section.contentInsets = self.sectionInset
//        section.orthogonalScrollingBehavior = .groupPagingCentered
//        
//        return section
        let itemSize = NSCollectionLayoutSize(widthDimension: itemStrategy.value.widthDimension,
                                              heightDimension: itemStrategy.value.heightDimension)
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: groupStrategy.value.widthDimension,
                                               heightDimension: groupStrategy.value.heightDimension)
        let group = NSCollectionLayoutGroup
        
    }
}
