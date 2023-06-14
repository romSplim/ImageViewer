//
//  ModuleBuilder.swift
//  ImageViewer
//
//  Created by ramil on 12.06.2023.
//

import UIKit

final class ModuleBuilder {
    
    //MARK: - Methods
    static func buildListPhotosModule() -> UIViewController {
        let view = ListImagesView()
        let router = ListImagesRouter()
        let networkService = NetworkService()
        let presenter = ListImagesPresenter(view: view,
                                            networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
    
    static func buildFavoritePhotoModule() -> UIViewController {
        let router = FavoriteListPhotosRouter()
        let view = FavoriteListPhotosView()
        let presenter = FavoriteListPhotosPresenter(view: view,
                                                    router: router)
        view.presenter = presenter
        return view
    }
    
    static func buildDetailPhotoModule(with photoDetail: PhotoItem) -> UIViewController {
        let router = DetailPhotoRouter()
        let view = DetailPhotoView()
        let presenter = DetailPhotoViewPresenter(view: view,
                                                 router: router,
                                                 photoDetail: photoDetail)
        view.presenter = presenter
        return view
    }
}
