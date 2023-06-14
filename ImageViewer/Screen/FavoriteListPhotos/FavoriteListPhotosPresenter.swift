//
//  FavoriteListPhotosPresenter.swift
//  ImageViewer
//
//  Created by ramil on 13.06.2023.
//

import UIKit
import RealmSwift

final class FavoriteListPhotosPresenter {
    
    //MARK: - Properties
    private weak var view: FavoriteListPhotosViewProtocol?
    private var router: FavoriteListPhotosRouter
    private var realmRepository: FavoritePhotosRepository
    
    private var favoritePhotos: [PhotoItem]?
    
    //MARK: - Init
    init(view: FavoriteListPhotosViewProtocol,
         router: FavoriteListPhotosRouter,
         realmRepository: FavoritePhotosRepository = .init()) {
        
        self.view = view
        self.router = router
        self.realmRepository = realmRepository
    }
    
    //MARK: - Methods
    func handleEditingActionCell(with indexPath: IndexPath,
                                 editingStyle: UITableViewCell.EditingStyle) {
        switch editingStyle {
        case .delete:
            guard let photo = getFavoritePhoto(with: indexPath) else {
                break
            }
            realmRepository.deletePhoto(photo)
            favoritePhotos = realmRepository.getPhotoList()
            view?.removeRowAt([indexPath])
        default:
            break
        }
    }
    
    func fetchAllPhotos() {
        favoritePhotos = realmRepository.getPhotoList()
        self.view?.reloadTable()
    }
    
    func getFavoritePhoto(with indexPath: IndexPath) -> PhotoItem? {
        return favoritePhotos?[indexPath.row]
    }
    
    func getFavoritePhotosCount() -> Int {
        return favoritePhotos?.count ?? 0
    }
    
    func showPhotoDetails(with photoDetail: PhotoItem) {
        guard let view = view as? FavoriteListPhotosView else { return }
        router.pushDetailController(from: view, with: photoDetail)
    }
}
