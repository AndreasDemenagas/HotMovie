//
//  MainTabBarControllert.swift
//  HotelMovieApp
//
//  IB DP Computer Science IA
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barStyle = .black
        tabBar.tintColor = .white
        
        let searchController = navigationController(viewController: SearchController(collectionViewLayout: UICollectionViewFlowLayout()), imageName: "search", title: "Search")
        let homeController = navigationController(viewController: HomeController(collectionViewLayout: UICollectionViewFlowLayout()), imageName: "home", title: "Home")
        let listController = navigationController(viewController: ListController(collectionViewLayout: UICollectionViewFlowLayout()), imageName: "list", title: "My List")
        
        viewControllers =  [homeController, listController ,searchController]
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
