//
//  CompositionalLayoutModelType.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/12/24.
//

import UIKit

/// CollectionLayout 을 만들기 위한 ModelType 으로 정의
public protocol CompositionalLayoutModelType {
    var identifier: String { get } // 필요없을지도? 일단 두자.

    var groupSize: NSCollectionLayoutSize { get set }
    var itemSize: NSCollectionLayoutSize { get set }
    
    var itemInset: NSDirectionalEdgeInsets { get set }
    var sectionInset: NSDirectionalEdgeInsets { get set }
    var itemModels: [String] { get }
    
    func createLayoutSection() -> NSCollectionLayoutSection
}
