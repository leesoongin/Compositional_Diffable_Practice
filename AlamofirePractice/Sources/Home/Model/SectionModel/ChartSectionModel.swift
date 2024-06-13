//
//  ChartSectionModel.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/12/24.
//

import UIKit

struct ChartSectionModel: CompositionalLayoutModelType {
    var sectionType: any CompositionalLayoutSectionType = HomeViewSection.chart
    
    var identifier: String = String(describing: ChartSectionModel.self)
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
    
    func createLayoutSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: self.itemSize)
        
        // group
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: self.groupSize, subitems: [item])
        
        // section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = self.sectionInset
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
}
