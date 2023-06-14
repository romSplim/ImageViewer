//
//  ListImagesRouter.swift
//  ImageViewer
//
//  Created by ramil on 13.06.2023.
//

import UIKit

final class ListImagesRouter {
    
    //MARK: - Methods
    func pushDetailController(from vc: UIViewController,
                              with photoDetail: PhotoItem) {
        
        let detailPhotoController = ModuleBuilder.buildDetailPhotoModule(with: photoDetail)
        vc.navigationController?.pushViewController(detailPhotoController,
                                                    animated: true)
    }
}
