//
//  AssistantErrorComponent.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/13/24.
//

import UIKit
import Combine
import CombineExt
import CombineCocoa
import SnapKit

struct AssistantCommonErrorAction: ActionEventItem {
    let identifier: String
}

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
    
    func prepareForReuse(content: ErrorView) {
        content.aLabel.numberOfLines = 1
        content.aButton.isSelected = false
    }
}

extension AssistantCommonErrorComponent {
    typealias ContentType = ErrorView

    func render(content: ContentType, context: Self, cancellable: inout Set<AnyCancellable>) {
        content.aLabel.text = "kadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakldkadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakldkadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakldkadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakldkadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakldkadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakld"
        
        content.aButton.setTitle(context.message, for: .normal)
        content.aButton.setTitleColor(.white, for: .normal)
        
        content.aButton.tapPublisher
            .sink { [weak content] _ in
                guard let content = content else { return }
                content.aButton.isSelected.toggle()
                content.aLabel.numberOfLines = content.aButton.isSelected ? 0 : 1
                content.actionEventEmitter.send(AssistantCommonErrorAction(identifier: context.identifier))
            }
            .store(in: &cancellable)
    }
}

final class ErrorView: BaseView, ActionEventEmitable {
    var actionEventEmitter = PassthroughSubject<ActionEventItem, Never>()
    
    let aButton = UIButton()
    let aLabel = UILabel()
    override func setup() {
        super.setup()
    }
    
    
    
    override func setupSubviews() {
        addSubview(aLabel)
        addSubview(aButton)
        
        aButton.backgroundColor = .systemBlue
    }
    
    override func setupConstraints() {
        aLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        aButton.snp.makeConstraints { make in
            make.top.equalTo(aLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
    }
}
