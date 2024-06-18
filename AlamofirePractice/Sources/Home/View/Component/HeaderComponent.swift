//
//  HeaderComponent.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/17/24.
//

import UIKit
import Combine
import CombineExt
import CombineCocoa
import SnapKit

struct HeaderComponent: Component {
    let identifier: String
    let message: String

    init(identifier: String, message: String) {
        self.identifier = identifier
        self.message = message
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(message)
    }
    
    func prepareForReuse(content: HeaderView) {
        content.aLabel.numberOfLines = 1
    }
}

extension HeaderComponent {
    typealias ContentType = HeaderView

    func render(content: ContentType, context: Self, cancellable: inout Set<AnyCancellable>) {
        content.aLabel.text = "jldsdjajlkaj"
    }
}

final class HeaderView: BaseView {
    let aLabel = UILabel()
    
    override func setup() {
        super.setup()
    }
    
    override func setupSubviews() {
        addSubview(aLabel)
        aLabel.text = "기본입니다."
    }
    
    override func setupConstraints() {
        aLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}
