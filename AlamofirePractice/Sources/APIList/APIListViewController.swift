//
//  APIListViewController.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/25/24.
//

import UIKit
import Combine

final class APIListViewController: ViewController<APIListView> {
    var cancellables = Set<AnyCancellable>()
    
    private var viewModel: APIListViewModel = APIListViewModel()
    lazy var adapter = CollectionViewAdapter(with: contentView.collectionView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        bindAdapter()
    }
    
    private func bindViewModel() {
        viewModel.requestComponentsPublisher
            .sink { [weak self] apiRequestComponent in
                _ = self?.adapter.receive(apiRequestComponent)
            }
            .store(in: &cancellables)
    }
    
    private func bindAdapter() {
        adapter.actionEventPublisher
            .sink { [weak self] actionItem in
                switch actionItem {
                case let action as AssistantCommonErrorAction:
                    self?.viewModel.requestAPI(with: action.identifier)
                default:
                    break
                }
            }
            .store(in: &cancellables)
    }
}
