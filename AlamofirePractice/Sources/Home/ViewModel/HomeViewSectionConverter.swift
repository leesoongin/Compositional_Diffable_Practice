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
            HomeFeedComponent(identifier: item.identifier)
        }
        
        let section = SectionModel(identifier: "chart_input_section_2",
                                   collectionLayout: createChartCollectionLayout2(),
                                   header: HeaderComponent(identifier: "header", message: "header/header"),
                                   footer: HeaderComponent(identifier: "footer", message: "footer/footer"),
                                   itemModels: mockComponents)
        return [section]
    }
    
    private func createChartCollectionLayout2() -> ChartSectionModel {
        let section = ChartSectionModel(itemStrategy: .item(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .estimated(352)),
                                        groupStrategy: .group(widthDimension: .fractionalWidth(1.0),
                                                              heightDimension: .estimated(352)),
                                        headerStrategy: .header(widthDimension: .fractionalWidth(1.0),
                                                                heightDimension: .estimated(32)),
                                        footerStrategy: .footer(widthDimension: .fractionalWidth(1.0),
                                                                heightDimension: .estimated(32)),
                                        groupSpacing: 8,
                                        sectionInset: .with(top: 8, bottom: 8),
                                        scrollBehavior: .groupPagingCentered)
        
        return section
    }
    
    private func createPlaylistSections2(with items: [HomeModel]) -> [SectionModelType] {
        let mockComponents = items.map { item in
            AssistantCommonErrorComponent(identifier: item.identifier, message: item.item)
        }

        let section = SectionModel(identifier: "playlist_input_section_2",
                                   collectionLayout: createPlaylistCollectionLayout2(),
                                   itemModels: mockComponents)
        return [section]
    }
    
    private func createPlaylistCollectionLayout2() -> PlaylistSectionModel {
        let section = PlaylistSectionModel(itemStrategy: .item(widthDimension: .fractionalWidth(1.0),
                                                               heightDimension: .estimated(50)),
                                           groupStrategy: .group(widthDimension: .fractionalWidth(1.0),
                                                                 heightDimension: .estimated(50)),
                                           sectionInset: .with(top: 8, bottom: 8),
                                           scrollBehavior: .none)
        
        return section
    }
}


//MARK: Chart Sections
extension HomeViewSectionConverter {
    private func createChartSections(with items: [HomeModel]) -> [SectionModelType] {
        let mockComponents = items.map { item in
            HomeFeedComponent(identifier: item.identifier)
        }
        
        let section = SectionModel(identifier: "chart_input_section",
                                   collectionLayout: createChartCollectionLayout(),
                                   itemModels: mockComponents)
        return [section]
    }
    
    private func createChartCollectionLayout() -> ChartSectionModel {
        let section = ChartSectionModel(itemStrategy: .item(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .estimated(352)),
                                        groupStrategy: .group(widthDimension: .fractionalWidth(1.0),
                                                              heightDimension: .estimated(352)),
                                        sectionInset: .with(top: 8, bottom: 8),
                                        scrollBehavior: .none)
        
        return section
    }
}

//MARK: Playlist Sections
extension HomeViewSectionConverter {
    private func createPlaylistSections(with items: [HomeModel]) -> [SectionModelType] {
        let mockComponents = items.map { item in
            HomeFeedComponent(identifier: item.identifier)
        }

        let section = SectionModel(identifier: "playlist_input_section",
                                   collectionLayout: createPlaylistCollectionLayout(),
                                   itemModels: mockComponents)
        return [section]
    }
    
    private func createPlaylistCollectionLayout() -> PlaylistSectionModel {
        let section = PlaylistSectionModel(itemStrategy: .item(widthDimension: .fractionalWidth(1.0),
                                                               heightDimension: .estimated(352)),
                                           groupStrategy: .group(widthDimension: .fractionalWidth(1.0),
                                                                 heightDimension: .estimated(352)),
                                           sectionInset: .with(top: 8, bottom: 8),
                                           scrollBehavior: .continuous)
        
        return section
    }
}
