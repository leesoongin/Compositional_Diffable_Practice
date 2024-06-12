//
//  HomeView.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/10/24.
//

import UIKit
import Then
import SnapKit
import Combine

class HomeView: BaseView {
    // UICollectionView 초기화
    lazy var collectionView = UICollectionView(scrollDirection: .vertical)
    let button = UIButton().then {
        $0.setTitle("눌렁주세여", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    override func setupSubviews() {
        backgroundColor = .cyan
        
        [collectionView, button].forEach {
            addSubview($0)
        }
    }
    
    override func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(button.snp.top)
        }
        
        button.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
    }
    
    func bind() {
        
    }
}

extension UICollectionView {
    public convenience init(scrollDirection: UICollectionView.ScrollDirection,
                            flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) {
        flowLayout.scrollDirection = scrollDirection
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.init(frame: .zero, collectionViewLayout: flowLayout)
        self.delaysContentTouches = false
        self.canCancelContentTouches = true
        self.backgroundColor = .clear
    }
}
