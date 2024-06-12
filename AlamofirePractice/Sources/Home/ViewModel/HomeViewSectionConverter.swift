//
//  HomeViewSectionConverter.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/11/24.
//

import Combine
import UIKit

final class HomeViewSectionConverter {
    func createSections(charts: [String],
                        playlists: [String]) -> [CompositionalLayoutModelType] {
        [
            createChartSections(with: charts),
            createPlaylistSections(with: playlists),
        ].flatMap { $0 }
    }
}

//MARK: Chart Sections
extension HomeViewSectionConverter {
    private func createChartSections(with items: [String]) -> [CompositionalLayoutModelType] {
        /// 이 밑은 바깥에서 주입하고, 여기선 받는걸로 하는게??
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
                                        sectionInset: sectionInset,
                                        itemModels: items)
        return [section]
    }
}

//MARK: Playlist Sections
extension HomeViewSectionConverter {
    private func createPlaylistSections(with items: [String]) -> [CompositionalLayoutModelType] {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(0.25))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .fractionalHeight(0.3))
        
        let itemInset = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16)
        
        let section = PlaylistSectionModel(identifier: "playlist_section",
                                           itemSize: itemSize,
                                           groupSize: groupSize,
                                           itemInset: itemInset,
                                           itemModels: items)

        return [section]
    }
}
