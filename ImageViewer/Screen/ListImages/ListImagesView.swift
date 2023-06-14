//
//  ListImages.swift
//  ImageViewer
//
//  Created by ramil on 11.06.2023.
//

import UIKit

protocol ListImagesViewProtocol: AnyObject {
    func reloadItems()
}

fileprivate enum Constant {
    static let searchPlaceholder = "Search image by name"
}

final class ListImagesView: UIViewController {
    
    //MARK: - Typealias
    typealias DataSource = UICollectionViewDiffableDataSource<Section, PhotoItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, PhotoItem>
    
    //MARK: - Section
    enum Section {
        case main
    }
    
    //MARK: - Properties
    var presenter: ListImagesPresenter?
    private var dataSource: DataSource?
    
    private let activityIndicator = UIActivityIndicatorView()
    private let searchController = UISearchController()
    
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isSearching: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: LayoutBuilder.generateLayout())
        collectionView.delegate = self
        collectionView.register(PhotoItemCell.self, forCellWithReuseIdentifier: PhotoItemCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupSearchBar()
        setupSubviews()
        setupDiffableDataSource()
        applySnapshot()
        presenter?.fetchPhotos()
    }
    
    //MARK: - Private methods
    private func setupSearchBar() {
        let searchBar = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.placeholder = Constant.searchPlaceholder
        navigationItem.searchController = searchController
    }
    
    private func setupDiffableDataSource() {
        dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, photoItem) ->
                UICollectionViewCell? in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoItemCell.identifier, for: indexPath) as? PhotoItemCell else {
                    return UICollectionViewCell()
                }
                cell.setup(with: photoItem)
                return cell
            })
    }
    
    private func applySnapshot(animatingDifferences: Bool = true) {
        guard let photos = presenter?.getPhotos(isSearching: isSearching) else { return }
        
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(photos)
        
        dataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    private func performDebouncingRequest() {
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(reload), object: searchController.searchBar)
        perform(#selector(reload),
                with: searchController.searchBar, afterDelay: 1)
    }
    
    @objc
    private func reload(_ searchBar: UISearchBar) {
        guard let name = searchBar.text,
              name.trimmingCharacters(in: .whitespaces) != "" else {
            return
        }
        presenter?.searchPhotos(with: name)
    }
    
    private func setupSubviews() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
}

//MARK: - UICollectionViewDelegate
extension ListImagesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        guard let photo = dataSource?.itemIdentifier(for: indexPath) else {
            return
        }
        presenter?.showPhotoDetail(with: photo)
    }
}

//MARK: - ListImagesViewProtocol
extension ListImagesView: ListImagesViewProtocol {
    func reloadItems() {
        applySnapshot()
    }
}

//MARK: - UISearchResultsUpdating
extension ListImagesView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        performDebouncingRequest()
    }
}
