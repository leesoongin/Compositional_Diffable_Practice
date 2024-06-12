//
//  APIButtonCell.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/10/24.
//

import UIKit
import Then
import SnapKit

final class APIButtonCell: UICollectionViewCell {
    static let reuseIdentifier: String = String(describing: APIButtonCell.self)
    
    let button = UIButton()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(button)
    }
    
    private func setupConstraints() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
    }
}

extension APIButtonCell {
    func bind(text: String) {
        button.setTitle(text, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
    }
}
