//
//  ListImagesPresenter.swift
//  ImageViewer
//
//  Created by ramil on 11.06.2023.
//

import Foundation

final class ListImagesPresenter {
    
    //MARK: - Properties
    private weak var view: ListImagesViewProtocol?
    
    private var networkService: NetworkService
    private var router: ListImagesRouter
    
    private var photos: [PhotoItem]?
    private var searchingPhotos: [PhotoItem]?
    
    //MARK: - Init
    init(view: ListImagesView,
         networkService: NetworkService,
         router: ListImagesRouter) {
        
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    //MARK: - Methods
    func getPhotos(isSearching: Bool) -> [PhotoItem] {
        if isSearching {
            return searchingPhotos ?? [PhotoItem]()
        }
        return photos ?? [PhotoItem]()
    }
    
    func fetchPhotos() {
        networkService.getRandomListPhotos { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.photos = success
                DispatchQueue.main.async {
                    self.view?.reloadItems()
                }
            case .failure(let failure):
                print(failure.message)
            }
        }
    }
    
    func searchPhotos(with name: String) {
        networkService.searchPhoto(with: name) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.searchingPhotos = success
                DispatchQueue.main.async {
                    self.view?.reloadItems()
                }
            case .failure(let failure):
                print(failure.message)
            }
        }
    }
    
    func showPhotoDetail(with photoDetail: PhotoItem) {
        guard let view = view as? ListImagesView else { return }
        router.pushDetailController(from: view, with: photoDetail)
    }
}
