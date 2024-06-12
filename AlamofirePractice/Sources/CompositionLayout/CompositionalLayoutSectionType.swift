//
//  CompositionalLayoutSection.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/12/24.
//

import UIKit

protocol CompositionalLayoutSection: Hashable, CaseIterable {
    func createCollectionLayout() -> NSCollectionLayoutSection
}
