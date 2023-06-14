//
//  DetailPhotoViewPresenter.swift
//  ImageViewer
//
//  Created by ramil on 13.06.2023.
//

import UIKit

final class DetailPhotoViewPresenter {
    
    //MARK: - Properties
    weak var view: DetailPhotoViewProtocol?
    private let router: DetailPhotoRouter
    private var photoDetail: PhotoItem
    private let realmRepository: FavoritePhotosRepository
    
    private var isPhotoExistInDataBase: Bool = false {
        didSet {
            updateButton()
        }
    }
    
    //MARK: - Init
    init(view: DetailPhotoViewProtocol,
         router: DetailPhotoRouter,
         photoDetail: PhotoItem,
         realmRepository: FavoritePhotosRepository = .init()) {
        
        self.view = view
        self.router = router
        self.photoDetail = photoDetail
        self.realmRepository = realmRepository
    }
    
    //MARK: - Methods
    func onViewDidLoad() {
        view?.setupDetailView(with: photoDetail)
    }
    
    func getPhotoDetail() -> PhotoItem {
        return photoDetail
    }
    
    func handleFavoriteButtonTap() {
        if isPhotoExistInDataBase {
            deletePhotoFromFavorite()
        } else {
            addPhotoToFavorite()
        }
    
        updateButton()
    }
    
    private func updateButton() {
        let state: FavoriteButton.ButtonState = isPhotoExistInDataBase ? .delete : .add
        self.view?.appleButtonTitleState(state)
    }
    
    func addPhotoToFavorite() {
        realmRepository.savePhoto(photoDetail)
        isPhotoExistInDataBase = true
    }
    
    func deletePhotoFromFavorite() {
        realmRepository.deletePhoto(photoDetail)
        isPhotoExistInDataBase = false
    }
    
    func checkIfObjectExist() {
        guard let photoID = photoDetail.id else { return }
        let photoExist = realmRepository.isFavoritePhotoExist(with: photoID)
        isPhotoExistInDataBase = photoExist
        updateButton()
    }
}
