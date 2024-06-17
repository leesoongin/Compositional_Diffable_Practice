//
//  HomeViewController.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/10/24.
//

import UIKit
import Combine
import CombineCocoa

final class HomeViewController: ViewController<HomeView> {
    var cancellables = Set<AnyCancellable>()
    
    private lazy var adapter = CollectionViewAdapter(with: contentView.collectionView)
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        bindViewActions()
        bindAdapter()
    }
    
    private func bindAdapter() {
        adapter.actionEventPublisher
            .sink { [weak self] actionItem in
                print(">> \(actionItem)")
                guard let self else { return }
                
                switch actionItem {
                case let action as AssistantCommonErrorAction:
                    self.adapter.updateDataSource(with: action.identifier)
                default:
                    break
                }
            }
            .store(in: &cancellables)
        
        adapter.didSelectItemPublisher
            .sink { [weak self] itemModel in
                print("model > \(itemModel)")
            }
            .store(in: &cancellables)
    }
    
    private func bindViewModel() {
        viewModel.compositionSections
            .sink { [weak self] sectionModels in
                print("models > \(sectionModels)")
                _ = self?.adapter.receive(sectionModels)
            }
            .store(in: &cancellables)
    }
}

//MARK: - Bind View Action
extension HomeViewController {
    private func bindViewActions() {
        contentView.button.tapPublisher
            .sink { [weak self] _ in
                self?.viewModel.addPlaylist()
            }
            .store(in: &cancellables)
    }
}
