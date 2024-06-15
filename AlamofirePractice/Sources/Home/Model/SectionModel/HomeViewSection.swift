//
//  HomeViewSection.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/12/24.
//

import UIKit

// 1. 해당 enum case 의 순서대로 section 이 생성된다.
// 2. 동일한 형태의 section 이라도, 다른 이름의 Case 가 필요하다. Why? DiffableDataSource의 키값에 들어가는 타입은 모두 Hashable.
enum HomeViewSection: CompositionalLayoutSectionType {
    case chart
    case playlist
    
    func createCollectionLayout() -> NSCollectionLayoutSection {
        switch self {
        case .chart:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(50))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(50))
            
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
                                                  heightDimension: .estimated(50))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                                   heightDimension: .estimated(50))
            
            let itemInset = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16)
            
            let section = PlaylistSectionModel(identifier: "playlist_section",
                                               itemSize: itemSize,
                                               groupSize: groupSize,
                                               itemInset: itemInset)
            return section.createLayoutSection()
        }
    }
}
