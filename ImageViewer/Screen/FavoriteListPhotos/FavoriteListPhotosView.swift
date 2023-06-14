//
//  FavoriteListPhotosView.swift
//  ImageViewer
//
//  Created by ramil on 13.06.2023.
//

import UIKit

protocol FavoriteListPhotosViewProtocol: AnyObject {
    func reloadTable()
    func removeRowAt(_ indexPaths: [IndexPath])
}

final class FavoriteListPhotosView: UIViewController {
    
    var presenter: FavoriteListPhotosPresenter?
    
    //MARK: - Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(FavoritePhotoCell.self,
                           forCellReuseIdentifier: FavoritePhotoCell.identifier)
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchAllPhotos()
    }
    
    //MARK: - Methods
    private func setupSubviews() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: - UITableViewDataSource
extension FavoriteListPhotosView: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        presenter?.getFavoritePhotosCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoritePhotoCell.identifier, for: indexPath) as? FavoritePhotoCell,
            let photo = presenter?.getFavoritePhoto(with: indexPath) else {
            return UITableViewCell()
        }
        
        cell.setup(with: photo)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension FavoriteListPhotosView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        if let photo = presenter?.getFavoritePhoto(with: indexPath) {
            presenter?.showPhotoDetails(with: photo)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        
        presenter?.handleEditingActionCell(with: indexPath,
                                           editingStyle: editingStyle)
    }
}

//MARK: - FavoriteListPhotosViewProtocol
extension FavoriteListPhotosView: FavoriteListPhotosViewProtocol {
    
    func removeRowAt(_ indexPaths: [IndexPath]) {
        tableView.deleteRows(at: indexPaths, with: .fade)
        popupAlert()
    }
    
    func reloadTable() {
        tableView.reloadData()
    }
}

