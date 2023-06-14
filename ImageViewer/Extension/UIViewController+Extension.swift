//
//  UIViewController+Extension.swift
//  ImageViewer
//
//  Created by ramil on 14.06.2023.
//

import UIKit

extension UIViewController {
    func popupAlert(title: String = "Удалено",
                    message: String? = "Фотография была успешно удалена") {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
