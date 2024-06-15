//
//  CollectionViewAdapter.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/11/24.
//

import UIKit
import Combine
import CombineCocoa

final class CollectionViewAdapter<Section: CompositionalLayoutSectionType>: NSObject {
    var cancellables = Set<AnyCancellable>()
    
    weak var collectionView: UICollectionView?
    var dataSource: UICollectionViewDiffableDataSource<Section, ListItem>!
    var registeredCellIdentifiers = Set<String>()
    
    private let didSelectItemSubject = PassthroughSubject<ItemModelType, Never>()
    var didSelectItemPublisher: AnyPublisher<ItemModelType, Never> {
        didSelectItemSubject.eraseToAnyPublisher()
    }
    
    private let actionEventSubject = PassthroughSubject<ActionEventItem, Never>()
    var actionEventPublisher: AnyPublisher<ActionEventItem, Never> {
        actionEventSubject.eraseToAnyPublisher()
    }
    
    private let inputSectionSubject = CurrentValueSubject<[SectionModelType], Never>([])
    private var sections: [SectionModelType] {
        inputSectionSubject.value
    }
    
    public init(with collectionView: UICollectionView) {
        super.init()
        
        self.collectionView = collectionView
        
        let layout = createLayout()
        self.collectionView?.setCollectionViewLayout(layout, animated: false)
        self.collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        setupCollectionDataSource()
        bindInputSections()
        bindDelegateEvent()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, enviroment -> NSCollectionLayoutSection? in
            let sectionAllCases = Array(Section.allCases)
            return sectionAllCases[sectionIndex].createCollectionLayout()
        }
    }
}

//MARK: - CollectionView Action & Data Binding
extension CollectionViewAdapter {
    /// Data Binding
    private func setupCollectionDataSource() {
        guard let collectionView = collectionView else { return }
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, ListItem>(collectionView: collectionView) { (collectionView, indexPath, dj) -> UICollectionViewCell? in
            guard let itemModel = self.itemModel(at: indexPath) else {
                return nil
            }
            
            //regist
            let reuseIdentifier = itemModel.viewType.getIdentifier()
            self.registerCellIfNeeded(with: itemModel)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            self.bindItemModelIfNeeded(to: cell, with: itemModel)
            self.bindActionEvent(with: cell)
            
            return cell
        }
    }
    
    /// Action Binding
    func setupInputSectionsIfNeeded(with sections: [SectionModelType]) {
        inputSectionSubject.send(sections)
    }
    
    private func bindInputSections() {
        inputSectionSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] sections in
                self?.updateSections(with: sections)
            }
            .store(in: &cancellables)
    }
    
    private func updateSections(with inputSections: [SectionModelType]) {
        guard !inputSections.isEmpty else { return }
        
        applySnapshot(with: inputSections)
    }
    
    private func applySnapshot(with sections: [SectionModelType]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ListItem>()
        
        let sectionAllCases = Array(Section.allCases)
        for (sectionModel, sectionType) in zip(sections, sectionAllCases) {
            let listItem = sectionModel.itemModels.map { ListItem(itemModel: $0 )}
            snapshot.appendSections([sectionType])
            snapshot.appendItems(listItem, toSection: sectionType)
        }
        
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func bindDelegateEvent() {
        collectionView?.didSelectItemPublisher
            .sink(receiveValue: { [weak self] indexPath in
                guard let itemModel = self?.dataSource.itemIdentifier(for: indexPath)?.itemModel else {
                    return
                }
                
                self?.didSelectItemSubject.send(itemModel)
            })
            .store(in: &cancellables)
    }
    
    private func cancelForPrepareForReuse(with view: UICollectionReusableView, cancellables: [AnyCancellable]) {
        guard let collectionView = collectionView else { return }
        
        view.prepareForReuseSubject
            .first()
            .sink(receiveValue: {_ in
                cancellables.forEach { $0.cancel() }
            }).store(in: &self.cancellables)
    }
}

//MARK: - Cell DataBinding && ActionBinding && Regist
extension CollectionViewAdapter {
    private func bindActionEvent(with view: UICollectionReusableView) {
        guard let actionEventEmitable: ActionEventEmitable = convertProtocol(with: view) else { return }
        
        let actionEventCancellables = actionEventEmitable.actionEventEmitter
            .sink { [weak self] actionEvent in
                self?.actionEventSubject.send(actionEvent)
            }
        actionEventCancellables
            .store(in: &cancellables)
        
        cancelForPrepareForReuse(with: view, cancellables: [actionEventCancellables])
    }
    
    
    private func bindItemModelIfNeeded(to cell: UICollectionReusableView, with itemModel: ItemModelType) {
        guard let cell = cell as? ItemModelBindableProtocol else { return }
        UIView.performWithoutAnimation {
            cell.bind(with: itemModel)
        }
    }
    
    private func registerCellIfNeeded(with itemModel: ItemModelType) {
        let reuseIdentifier = itemModel.viewType.getIdentifier()
        guard registeredCellIdentifiers.contains(reuseIdentifier) == false else { return }
        
        collectionView?.register(itemModel.viewType.getClass(), forCellWithReuseIdentifier: reuseIdentifier)
        registeredCellIdentifiers.insert(reuseIdentifier)
    }
}

//MARK: - Finder
extension CollectionViewAdapter {
    func itemModel(at indexPath: IndexPath) -> ItemModelType? {
        sections[safe: indexPath.section]?.itemModels[safe: indexPath.item]
    }
    
    func findIndexPathByIdentifier(with identifier: String) -> IndexPath? {
        var target: IndexPath? = nil
        sections.enumerated().forEach { index, section in
            if let row = section.itemModels.firstIndex(where: { $0.identifier == identifier }) {
                target = IndexPath(item: row, section: index)
            }
        }
        
        return target
    }
    
    func convertProtocol<P>(with view: UICollectionReusableView) -> P? {
        if let cell = view as? UICollectionViewCell,
           let target = (cell as? P) ?? cell.contentView.subviews.first as? P {
            return target
        } else {
            return nil
        }
    }
}
