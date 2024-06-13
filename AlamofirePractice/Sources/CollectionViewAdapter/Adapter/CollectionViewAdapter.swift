//
//  CollectionViewAdapter.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/11/24.
//

import Combine
import UIKit

final class CollectionViewAdapter<Section: CompositionalLayoutSectionType>: NSObject {
    var cancellables = Set<AnyCancellable>()
    
    weak var collectionView: UICollectionView?
    var dataSource: UICollectionViewDiffableDataSource<Section, ListItem>!
    
    private let inputSectionSubject = CurrentValueSubject<[SectionModelType], Never>([])
    private var sections: [SectionModelType] {
        inputSectionSubject.value
    }
    
    public init(with collectionView: UICollectionView) {
        super.init()
        
        self.collectionView = collectionView
        self.collectionView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let layout = createLayout()
        self.collectionView?.setCollectionViewLayout(layout, animated: false)
        
        
        bindInputSections()
        setupCollectionDataSource()
        initializeSnapshot()
    }
    
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
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, enviroment -> NSCollectionLayoutSection? in
            let sectionAllCases = Array(Section.allCases)
            return sectionAllCases[sectionIndex].createCollectionLayout()
        }
    }
    
    private func registerCellIfNeeded(with itemModel: ItemModelType) {
//        guard registeredCellIdentifiers.contains(identifier) == false else { return }
        collectionView?.register(itemModel.viewType.getClass(), forCellWithReuseIdentifier: itemModel.viewType.getIdentifier())
    }
    
    
    private func bindItemModelIfNeeded(to cell: UICollectionReusableView, with itemModel: ItemModelType) {
        guard let cell = cell as? ItemModelBindableProtocol else { return }
        UIView.performWithoutAnimation {
            cell.bind(with: itemModel)
        }
    }
    
    private func setupCollectionDataSource() {
        guard let collectionView = collectionView else { return }
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, ListItem>(collectionView: collectionView) { (collectionView, indexPath, dj) -> UICollectionViewCell? in
            guard let itemModel = self.itemModel(at: indexPath) else {
                return nil
            }
            
            let reuseIdentifier = itemModel.viewType.getIdentifier()
            self.registerCellIfNeeded(with: itemModel)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
            self.bindItemModelIfNeeded(to: cell, with: itemModel)
            cell.backgroundColor = .systemBlue
            
            return cell
        }
    }
    
    private func initializeSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ListItem>()
        
        let sectionAllCases = Array(Section.allCases)
        snapshot.appendSections(sectionAllCases)
        
        dataSource.apply(snapshot, animatingDifferences: true)
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
}

extension CollectionViewAdapter {
    func itemModel(at indexPath: IndexPath) -> ItemModelType? {
        sections[safe: indexPath.section]?.itemModels[safe: indexPath.item]
    }
}

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
