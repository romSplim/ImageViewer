//
//  FavoriteListPhotosRouter.swift
//  ImageViewer
//
//  Created by ramil on 13.06.2023.
//

import UIKit


final class FavoriteListPhotosRouter {
    
    //MARK: - Methods
    func pushDetailController(from vc: UIViewController,
                              with photo: PhotoItem) {
        
        let detailPhotoController = ModuleBuilder.buildDetailPhotoModule(with: photo)
        vc.navigationController?.pushViewController(detailPhotoController,
                                                    animated: true)
    }
}

