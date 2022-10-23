//
//  TabBarController.swift
//  ObservedPattern
//
//  Created by Kelly Chui on 2022/10/23.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        UITabBar.appearance().isTranslucent = false
        setupItems()
    }
    
    func setupItems() {
        let firstTab = MainViewController()
        let secondTab = SubViewController()
        firstTab.tabBarItem = UITabBarItem(title: "Main", image: UIImage(systemName: "lasso"), selectedImage: UIImage(systemName: "lasso"))
        secondTab.tabBarItem = UITabBarItem(title: "VC1", image: UIImage(systemName: "lasso"), selectedImage: UIImage(systemName: "lasso"))
        self.viewControllers = [firstTab, secondTab]
    }
}
