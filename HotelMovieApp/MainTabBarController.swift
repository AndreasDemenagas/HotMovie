//
//  MainTabBarController.swift
//  HotelMovieApp
//
//  Created by Andrew Demenagas on 4/5/20.
//  Copyright © 2020 Andrew Demenagas. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barStyle = .black
        tabBar.tintColor = .white
        
        let searchController = navigationController(viewController: SearchController(), imageName: "search", title: "Search")
        let homeController = navigationController(viewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout()), imageName: "home", title: "Home")
        
        let listVC = ListController(collectionViewLayout: UICollectionViewFlowLayout())
        let listController = navigationController(viewController: listVC, imageName: "list-icon", title: "My List")
        
        viewControllers =  [homeController, listController, searchController]
        
        UITabBarItem.appearance().titlePositionAdjustment = .init(horizontal: 0, vertical: -4)
        
        for item in tabBar.items! {
            item.imageInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    fileprivate func navigationController(viewController: UIViewController, imageName: String, title: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .black
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = UIImage(named: imageName)
        return navigationController
    }
    
}
