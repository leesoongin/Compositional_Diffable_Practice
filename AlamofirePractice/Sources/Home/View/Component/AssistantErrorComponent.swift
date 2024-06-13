//
//  AssistantErrorComponent.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/13/24.
//

import UIKit
import Combine
import CombineExt
import SnapKit

struct AssistantCommonErrorComponent: Component {
    let identifier: String
    let message: String

    init(identifier: String, message: String) {
        self.identifier = identifier
        self.message = message
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(message)
    }
}

extension AssistantCommonErrorComponent {
    typealias ContentType = ErrorView

    func render(content: ContentType, context: Self, cancellable: inout Set<AnyCancellable>) {
        content.label.text = context.message
    }
}

final class ErrorView: BaseView {
    let container = UIView()
    let label = UILabel()
    override func setup() {
        super.setup()
    }
    
    override func setupSubviews() {
        addSubview(label)
        
        label.numberOfLines = 0
        label.backgroundColor = .white
    }
    
    override func setupConstraints() {
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
