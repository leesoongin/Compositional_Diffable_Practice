//
//  PlaylistSectionModel.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/12/24.
//

import UIKit

struct PlaylistSectionModel: CompositionalLayoutModelType {
    var sectionType: any CompositionalLayoutSectionType = HomeViewSection.playlist
    
    var identifier: String = String(describing: PlaylistSectionModel.self)
    var groupSize: NSCollectionLayoutSize
    var itemSize: NSCollectionLayoutSize
    var itemInset: NSDirectionalEdgeInsets
    var sectionInset: NSDirectionalEdgeInsets
    var itemModels: [String]
    //    var itemModels: [ItemModelType]
    
    init(identifier: String,
         itemSize: NSCollectionLayoutSize,
         groupSize: NSCollectionLayoutSize,
         itemInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0),
         sectionInset: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0),
         itemModels: [String] = []) {
        self.identifier = identifier
        self.groupSize = groupSize
        self.itemSize = itemSize
        self.itemInset = itemInset
        self.sectionInset = sectionInset
        self.itemModels = itemModels
    }
    
    // 이건 어뎁터에서 호출?하는게? 나을듯?
    func createLayoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: self.itemSize)
        item.contentInsets = self.itemInset
        
        // group
        let group = NSCollectionLayoutGroup.vertical(layoutSize: self.groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = self.sectionInset
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
}
