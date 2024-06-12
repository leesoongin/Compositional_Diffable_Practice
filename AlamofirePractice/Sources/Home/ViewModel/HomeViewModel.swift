//
//  HomeViewModel.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/11/24.
//

import Foundation
import Combine

final class HomeViewModel {
    private let converter = HomeViewSectionConverter()
    
    var compositionSections = CurrentValueSubject<[CompositionalLayoutModelType], Never>([])
    var mockCharts = [
        "chart1",
        "chart2",
        "chart3",
        "chart4",
        "chart5",
        "chart6",
        "chart7",
        "chart8",
    ]
    
    var mockPlaylists = [
        "playlist1",
        "playlist2",
        "playlist3",
        "playlist4",
        "playlist5",
        "playlist6",
        "playlist7",
        "playlist8",
        "playlist9",
        "playlist10",
        "playlist11",
        "playlist12",
        "playlist13"
    ]
    
    init() {
        compositionSections.send(converter.createSections(charts: mockCharts,
                                                          playlists: mockPlaylists))
    }
    
    func addPlaylist() {
        mockPlaylists.append(UUID().uuidString)
        
        compositionSections.send(converter.createSections(charts: mockCharts,
                                                          playlists: mockPlaylists))
    }
}
