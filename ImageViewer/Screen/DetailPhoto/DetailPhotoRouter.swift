//
//  DetailPhotoRouter.swift
//  ImageViewer
//
//  Created by ramil on 13.06.2023.
//

import UIKit

final class DetailPhotoRouter {
    
    //MARK: - Methods
    func popController(vc: UIViewController,
                       with photoDetail: PhotoItem) {
        vc.navigationController?.popViewController(animated: true)
    }
}
