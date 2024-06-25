//
//  APIListView.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/25/24.
//

import UIKit
import SnapKit
import Then


final class APIListView: BaseView {
    let collectionView = UICollectionView(scrollDirection: .vertical)
    
    override func setupSubviews() {
        addSubview(collectionView)
    }
    
    override func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
