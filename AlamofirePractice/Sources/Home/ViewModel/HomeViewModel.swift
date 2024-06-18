//
//  HomeViewModel.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/11/24.
//

import Foundation
import Combine

struct HomeModel {
    let identifier: String
    let item: String
}

final class HomeViewModel {
    private let converter = HomeViewSectionConverter()
    
    var compositionSections = CurrentValueSubject<[SectionModelType], Never>([])
 
    var mockCharts: [HomeModel] = []
    var mockPlaylist: [HomeModel] = []
    var mockCharts2: [HomeModel] = []
    var mockPlaylist2: [HomeModel] = []
    
    init() {
        mockCharts = Array(1...5).map { HomeModel(identifier: UUID().uuidString, item: "\($0)") }
        mockPlaylist = Array(1...14).map { HomeModel(identifier: UUID().uuidString, item: "\($0)") }
        mockCharts2 = Array(1...7).map { HomeModel(identifier: UUID().uuidString, item: "\($0)") }
        mockPlaylist2 = Array(1...7).map { HomeModel(identifier: UUID().uuidString, item: "\($0)") }
        
        compositionSections.send(converter.createSections(charts: mockCharts,
                                                          playlists: mockPlaylist,
                                                          one: mockCharts2,
                                                          tow: mockPlaylist2))
    }
    
    func addPlaylist() {
        mockPlaylist.append(HomeModel(identifier: UUID().uuidString, item: "추카추카가가"))
        
        compositionSections.send(converter.createSections(charts: mockCharts,
                                                          playlists: mockPlaylist,
                                                          one: mockCharts2,
                                                          tow: mockPlaylist2))
    }
}
