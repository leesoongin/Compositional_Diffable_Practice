//
//  CollectionViewAdapter.swift
//  AlamofirePractice
//
//  Created by 이숭인 on 6/11/24.
//

import Combine
import UIKit

final class CollectionViewAdapter: NSObject {
    var cancellables = Set<AnyCancellable>()
    
    weak var collectionView: UICollectionView?
    var dataSource: UICollectionViewDiffableDataSource<HomeViewSection, String>!
    var snapshot = NSDiffableDataSourceSnapshot<HomeViewSection, String>()
    
    private let inputSectionSubject = CurrentValueSubject<[CompositionalLayoutModelType], Never>([])
    
    private var sections: [CompositionalLayoutModelType] {
        inputSectionSubject.value
    }
    
    public init(with collectionView: UICollectionView) {
        super.init()
        
        self.collectionView = collectionView
        
        let layout = createLayout()
        self.collectionView?.setCollectionViewLayout(layout, animated: false)
        
        bindInputSections()
        setupCollectionDataSource()
        initializeSnapshot()
    }
    
    private func setupInputSectionsIfNeeded(with sections: [CompositionalLayoutModelType]) {
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
    
    private func updateSections(with inputSections: [CompositionalLayoutModelType]) {
        guard !inputSections.isEmpty else { return }
        
        HomeViewSection.allCases.forEach { section in
            applySnapshot(with: inputSections, toSection: section)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, enviroment -> NSCollectionLayoutSection? in
            return HomeViewSection(rawValue: sectionIndex)?.createCollectionLayout()
        }
    }
    
    private func setupCollectionDataSource() {
        guard let collectionView = collectionView else { return }
        
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.dataSource = UICollectionViewDiffableDataSource<HomeViewSection, String>(collectionView: collectionView) { (collectionView, indexPath, dj) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .systemBlue
            
            return cell
        }
    }
    
    private func initializeCollectionLayout() {
        
    }
    
    private func initializeSnapshot() {
        snapshot.appendSections(HomeViewSection.allCases)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func applySnapshot(with sections: [CompositionalLayoutModelType], toSection section: HomeViewSection) {
        let models = sections.filter { $0.sectionType == section }.flatMap { $0.itemModels }
        snapshot.appendItems(models, toSection: section)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension CollectionViewAdapter: Subscriber {
    public typealias Input = [CompositionalLayoutModelType]
    public typealias Failure = Never

    public func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    public func receive(completion: Subscribers.Completion<Never>) {
        // do nothing
    }

    public func receive(_ input: [CompositionalLayoutModelType]) -> Subscribers.Demand {
        setupInputSectionsIfNeeded(with: input)
        return .none
    }
}
