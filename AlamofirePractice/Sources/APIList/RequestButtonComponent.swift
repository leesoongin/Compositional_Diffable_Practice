//
//  RequestButtonComponent.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/25/24.
//

import UIKit
import Then
import SnapKit
import Combine

struct RequestButtonComponent: Component {
    let identifier: String
    let buttonTitle: String
    let response: String
    
    init(identifier: String, buttonTitle: String, response: String) {
        self.identifier = identifier
        self.buttonTitle = buttonTitle
        self.response = response
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(buttonTitle)
        hasher.combine(response)
    }
}

extension RequestButtonComponent {
    typealias ContentType = RequestButtonView
    
    func render(content: ContentType, context: Self, cancellable: inout Set<AnyCancellable>) {
        content.requestButton.setTitle(context.buttonTitle, for: .normal)
        content.responseLabel.text = context.response
        
        content.requestButton.tapPublisher
            .sink { [weak content] _ in
                content?.actionEventEmitter.send(AssistantCommonErrorAction(identifier: context.identifier))
            }
            .store(in: &cancellable)
    }
}
// ContainsButton 프로토콜을 만들자
final class RequestButtonView: BaseView, ActionEventEmitable {
    var actionEventEmitter = PassthroughSubject<ActionEventItem, Never>()
    
    let containerView = UIView()
    let requestButton = UIButton().then {
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .systemBlue
    }
    let responseLabel = UILabel().then {
        $0.numberOfLines = 0
    }
    
    override func setupSubviews() {
        addSubview(containerView)
        backgroundColor = .cyan
        
        [requestButton, responseLabel].forEach { subview in
            containerView.addSubview(subview)
        }
    }
    
    override func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        requestButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(32)
        }
        
        responseLabel.snp.makeConstraints { make in
            make.top.equalTo(requestButton.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
