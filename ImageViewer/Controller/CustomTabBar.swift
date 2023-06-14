//
//  CustomTabBar.swift
//  ImageViewer
//
//  Created by ramil on 13.06.2023.
//

import UIKit

final class CustomTabBar: UITabBarController {
    
    //MARK: - Properties
    private let tabBarItems: [TabBarItem] = [.randomList,
                                             .favoritePhoto]
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    //MARK: - Methods
    func setupTabs() {
        viewControllers = tabBarItems.map { tab in
            switch tab {
            case .randomList:
                let randomListView = ModuleBuilder.buildListPhotosModule()
                randomListView.tabBarItem.image = tab.icon
                randomListView.title = tab.title
                return UINavigationController(rootViewController: randomListView)
                
            case .favoritePhoto:
                let favoritePhotoView = ModuleBuilder.buildFavoritePhotoModule()
                favoritePhotoView.tabBarItem.image = tab.icon
                favoritePhotoView.title = tab.title
                return UINavigationController(rootViewController: favoritePhotoView)
            }
        }
    }
}

extension CustomTabBar {
    enum TabBarItem {
        case randomList
        case favoritePhoto
        
        var title: String {
            switch self {
            case .randomList:
                return "Random photos"
            case .favoritePhoto:
                return "Favorite"
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .randomList:
                return UIImage(systemName: "photo.stack")
            case .favoritePhoto:
                return UIImage(systemName: "star")
            }
        }
    }
}
