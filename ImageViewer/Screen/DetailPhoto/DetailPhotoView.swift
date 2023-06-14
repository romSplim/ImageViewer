//
//  DetailPhotoView.swift
//  ImageViewer
//
//  Created by ramil on 13.06.2023.
//

import UIKit

protocol DetailPhotoViewProtocol: AnyObject {
    func setupDetailView(with photo: PhotoItem)
    func appleButtonTitleState(_ state: FavoriteButton.ButtonState)
}

final class DetailPhotoView: UIViewController {
    
    //MARK: - Properties
    var presenter: DetailPhotoViewPresenter?
    
    private let detailView = DetailView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        handleFavoriteButtonAction()
        presenter?.onViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.checkIfObjectExist()
    }
    
    //MARK: - Private methods
    private func handleFavoriteButtonAction() {
        detailView.onFavoriteButtonTap = {
            self.presenter?.handleFavoriteButtonTap()
        }
    }
    
    private func setupSubviews() {
        view.addSubview(detailView)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension DetailPhotoView: DetailPhotoViewProtocol {
    func setupDetailView(with photo: PhotoItem) {
        detailView.setup(with: photo)
    }
    
    func appleButtonTitleState(_ state: FavoriteButton.ButtonState) {
        detailView.setFavoriteButtonState(state)
    }
}

