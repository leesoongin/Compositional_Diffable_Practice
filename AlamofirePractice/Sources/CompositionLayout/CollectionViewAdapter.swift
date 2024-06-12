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
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
    
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
        
        Section.allCases.forEach { section in
            applySnapshot(with: inputSections, toSection: section)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, enviroment -> NSCollectionLayoutSection? in
            let sectionAllCases = Array(Section.allCases)
            return sectionAllCases[sectionIndex].createCollectionLayout()
        }
    }
    
    private func setupCollectionDataSource() {
        guard let collectionView = collectionView else { return }
        
        self.collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) { (collectionView, indexPath, dj) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            cell.backgroundColor = .systemBlue
            
            return cell
        }
    }
    
    private func initializeCollectionLayout() {
        
    }
    
    private func initializeSnapshot() {
        let sectionAllCases = Array(Section.allCases)
        snapshot.appendSections(sectionAllCases)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func applySnapshot(with sections: [CompositionalLayoutModelType], toSection sectionType: Section) {
        let models = sections.filter { section in
            guard let castedSectionType = section.sectionType as? Section else {
                return false
            }
            
            return castedSectionType == sectionType
        }
            .flatMap { $0.itemModels }
        
        snapshot.appendItems(models, toSection: sectionType)
        
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
