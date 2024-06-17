//
//  CompositionalLayoutModelType.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/12/24.
//

import UIKit

/// CollectionLayout 을 만들기 위한 ModelType 으로 정의
public protocol CompositionalLayoutModelType {
    var itemStrategy: SizeStrategy { get set }
    var groupStrategy: SizeStrategy { get set }
    
    var headerStrategy: SizeStrategy? { get }
    var footerStrategy: SizeStrategy? { get }
    
    var groupSpacing: CGFloat { get }
    var groupAxis: 
    var sectionInset: NSDirectionalEdgeInsets { get set }
    
    var scrollBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior { get }
    
    func createLayoutSection() -> NSCollectionLayoutSection
}

public enum SizeStrategy {
    case item(widthDimension: NSCollectionLayoutDimension, heightDimension: NSCollectionLayoutDimension)
    case group(widthDimension: NSCollectionLayoutDimension, heightDimension: NSCollectionLayoutDimension)
    case header(widthDimension: NSCollectionLayoutDimension, heightDimension: NSCollectionLayoutDimension)
    case footer(widthDimension: NSCollectionLayoutDimension, heightDimension: NSCollectionLayoutDimension)
    
    var value: (widthDimension: NSCollectionLayoutDimension, heightDimension: NSCollectionLayoutDimension) {
        switch self {
        case let .item(width, height),
            let .group(width, height),
            let .header(width, height),
            let .footer(width, height):
            return (width, height)
        }
    }
}

public extension NSDirectionalEdgeInsets {
    var horizontal: CGFloat { self.leading + self.trailing }
    var vertical: CGFloat { self.top + self.bottom }
}

public extension NSDirectionalEdgeInsets {
    init(vertical: CGFloat, horizontal: CGFloat) {
        self.init(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
    
    static func with(top: CGFloat = 0, leading: CGFloat = 0, bottom: CGFloat = 0, trailing: CGFloat = 0) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: top, leading: leading, bottom: bottom, trailing: trailing)
    }
    
    static func with(vertical: CGFloat = 0, horizontal: CGFloat = 0) -> NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: vertical, leading: horizontal, bottom: vertical, trailing: horizontal)
    }
}
