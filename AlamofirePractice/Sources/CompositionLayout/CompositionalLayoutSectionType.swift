//
//  CompositionalLayoutSectionType.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/12/24.
//

import UIKit

protocol CompositionalLayoutSectionType: Hashable, CaseIterable {
    func createCollectionLayout() -> NSCollectionLayoutSection
}
