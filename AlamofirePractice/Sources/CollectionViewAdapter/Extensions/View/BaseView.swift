//
//  BaseView.swift
//  ProtocolDrivenCellBuilder
//
//  Created by 이숭인 on 6/4/24.
//

import UIKit

open class BaseView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func setup() {
        backgroundColor = .white
        
        setupSubviews()
        setupConstraints()
    }
    
    open func setupSubviews() {
        
    }
    
    open func setupConstraints() {
        
    }
}
