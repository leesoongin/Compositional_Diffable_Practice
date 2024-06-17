//
//  HomeViewSectionConverter.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/11/24.
//

import Combine
import UIKit

// homeSection 의 case 순서에 따라 component를 만들어야함
// 이걸 강제할 방법은 없을가?
// HomeViewSection을 Converter 처럼 쓸 수는 없을까?
final class HomeViewSectionConverter {
    func createSections(charts: [HomeModel],
                        playlists: [HomeModel],
                        one: [HomeModel],
                        tow: [HomeModel]) -> [SectionModelType] {
        [
            createChartSections(with: charts),
            createPlaylistSections(with: playlists),
            createChartSections2(with: one),
            createPlaylistSections2(with: tow),
        ].flatMap { $0 }
    }
}

//MARK: - Only Test Sections
extension HomeViewSectionConverter {
    private func createChartSections2(with items: [HomeModel]) -> [SectionModelType] {
        let mockComponents = items.map { item in
            AssistantCommonErrorComponent(identifier: item.identifier, message: item.item)
        }
        
        let section = SectionModel(identifier: "chart_input_section_2",
                                   collectionLayout: createChartCollectionLayout(),
                                   itemModels: mockComponents)
        return [section]
    }
    
    private func createPlaylistSections2(with items: [HomeModel]) -> [SectionModelType] {
        let mockComponents = items.map { item in
            AssistantCommonErrorComponent(identifier: item.identifier, message: item.item)
        }

        let section = SectionModel(identifier: "playlist_input_section_2",
                                   collectionLayout: createPlaylistCollectionLayout(),
                                   itemModels: mockComponents)
        return [section]
    }
}


//MARK: Chart Sections
extension HomeViewSectionConverter {
    private func createChartSections(with items: [HomeModel]) -> [SectionModelType] {
        let mockComponents = items.map { item in
            AssistantCommonErrorComponent(identifier: item.identifier, message: item.item)
        }
        
        let section = SectionModel(identifier: "chart_input_section",
                                   collectionLayout: createChartCollectionLayout(),
                                   itemModels: mockComponents)
        return [section]
    }
    
    private func createChartCollectionLayout() -> ChartSectionModel {
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
        
        return section
    }
}

//MARK: Playlist Sections
extension HomeViewSectionConverter {
    private func createPlaylistSections(with items: [HomeModel]) -> [SectionModelType] {
        let mockComponents = items.map { item in
            AssistantCommonErrorComponent(identifier: item.identifier, message: item.item)
        }

        let section = SectionModel(identifier: "playlist_input_section",
                                   collectionLayout: createPlaylistCollectionLayout(),
                                   itemModels: mockComponents)
        return [section]
    }
    
    private func createPlaylistCollectionLayout() -> PlaylistSectionModel {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .estimated(50))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),
                                               heightDimension: .estimated(50))
        
        let itemInset = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16)
        
        let section = PlaylistSectionModel(identifier: "playlist_section",
                                           itemSize: itemSize,
                                           groupSize: groupSize,
                                           itemInset: itemInset)
        return section
    }
}
