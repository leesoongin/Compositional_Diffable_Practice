//
//  HomeViewSection.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/12/24.
//

import UIKit

enum HomeViewSection: CompositionalLayoutSectionType {
    case chart
    case playlist
    
    func createCollectionLayout() -> NSCollectionLayoutSection {
        switch self {
        case .chart:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .fractionalHeight(1.0))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                   heightDimension: .fractionalHeight(0.3))
            
            let itemInset = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            let sectionInset = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
            let section = ChartSectionModel(identifier: "chart_section",
                                            itemSize: itemSize,
                                            groupSize: groupSize,
                                            itemInset: itemInset,
                                            sectionInset: sectionInset)
            return section.createLayoutSection()
        case .playlist:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(0.25))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                   heightDimension: .fractionalHeight(0.3))
            
            let itemInset = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16)
            
            let section = PlaylistSectionModel(identifier: "playlist_section",
                                               itemSize: itemSize,
                                               groupSize: groupSize,
                                               itemInset: itemInset)
            return section.createLayoutSection()
        }
    }
}
