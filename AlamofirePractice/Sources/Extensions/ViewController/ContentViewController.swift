//
//  ContentViewController.swift
//  ProtocolDrivenCellBuilder
//
//  Created by 이숭인 on 6/4/24.
//

import UIKit

class ContentViewController<ContentView: UIView>: UIViewController {
    public typealias ContentViewType = ContentView
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var contentView: ContentView {
        view as! ContentView
    }
    
    open override func loadView() {
        view = ContentView(frame: .zero)
    }
}
