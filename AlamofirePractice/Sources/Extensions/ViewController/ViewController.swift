//
//  ViewController.swift
//  ProtocolDrivenCellBuilder
//
//  Created by 이숭인 on 6/4/24.
//

import UIKit
import Combine
import CombineCocoa

class ViewController<ContentView: UIView>: ContentViewController<ContentView> {
    public override init() {
        super.init()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupKeyboardDismissableIfNeeded()
    }
}

extension ViewController {
    private func setupKeyboardDismissableIfNeeded() {
        guard let keyboardDismissable = self as? KeyboardDismissable else { return }
        keyboardDismissable.setupKeyboardDismissable()
    }
}

public protocol KeyboardDismissable: UIViewController {
    func setupKeyboardDismissable()
}

extension KeyboardDismissable {
    public func setupKeyboardDismissable(cancellables: inout Set<AnyCancellable>) {
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        
        tapGesture.tapPublisher
            .sink { [weak self] _ in
                self?.view.endEditing(true)
            }
            .store(in: &cancellables)
    }
}


