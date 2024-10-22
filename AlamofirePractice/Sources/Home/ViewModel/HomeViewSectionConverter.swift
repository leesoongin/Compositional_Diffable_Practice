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
                        playlists: [HomeModel]) -> [SectionModelType] {
        [
            createChartSections(with: charts),
            createPlaylistSections(with: playlists),
        ].flatMap { $0 }
    }
}

//MARK: Chart Sections
extension HomeViewSectionConverter {
    private func createChartSections(with items: [HomeModel]) -> [SectionModelType] {
        let mockComponents = items.map { item in
            AssistantCommonErrorComponent(identifier: item.identifier, message: item.item)
        }
        
        let section = SectionModel(identifier: "edit_input_section",
                                   itemModels: mockComponents)
        return [section]
    }
}

//MARK: Playlist Sections
extension HomeViewSectionConverter {
    private func createPlaylistSections(with items: [HomeModel]) -> [SectionModelType] {
        let mockComponents = items.map { item in
            AssistantCommonErrorComponent(identifier: item.identifier, message: item.item)
        }

        let section = SectionModel(identifier: "edit_input_section",
                                   itemModels: mockComponents)
        return [section]
    }
}
