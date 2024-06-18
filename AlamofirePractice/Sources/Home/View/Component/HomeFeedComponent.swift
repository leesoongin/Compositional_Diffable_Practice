//
//  HomeFeedComponent.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/18/24.
//

import UIKit
import Combine
import SnapKit
import Then

struct HomeFeedComponent: Component {
    let identifier: String

    init(identifier: String) {
        self.identifier = identifier
    }

    func hash(into hasher: inout Hasher) {
        
    }
    
    func prepareForReuse(content: HomeFeedView) {
        content.aLabel.numberOfLines = 1
    }
}

extension HomeFeedComponent {
    typealias ContentType = HomeFeedView

    func render(content: ContentType, context: Self, cancellable: inout Set<AnyCancellable>) {
        content.aLabel.text = "kadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakldkadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakldkadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakldkadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakldkadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakldkadsjljldsdjajlkajdlajdladjlkadjlkajdklajdkljkljakdjkaldjklajdkdjkadjklasjdklajdklajskdljakld"
        
        content.aButton.setTitle("눌러랏", for: .normal)
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

final class HomeFeedView: BaseView, ActionEventEmitable {
    var actionEventEmitter = PassthroughSubject<ActionEventItem, Never>()
    
    let imageView = UIImageView().then {
        $0.image = UIImage(named: "yellowSky")
    }
    
    let aLabel = UILabel().then {
        $0.numberOfLines = 1
    }
    
    let aButton = UIButton().then {
        $0.backgroundColor = .systemBlue
    }
    
    override func setup() {
        super.setup()
    }
    
    override func setupSubviews() {
        addSubview(imageView)
        addSubview(aLabel)
        addSubview(aButton)
    }
    
    override func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(320)
            make.bottom.equalTo(aLabel.snp.top).offset(-16)
        }
        
        aLabel.snp.makeConstraints{ make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(aButton.snp.top).offset(-16)
        }
        
        aButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
