//
//  MainTabBarVC.swift
//  OFood
//
//  Created by tamzimun on 18.10.2022.
//

import UIKit

class MainTabBarVC: UITabBarController {
    
    private let titles: [String] = ["Меню", "Контакты", "Профиль", "Корзина"]
    private let images: [UIImage] = [
        UIImage(systemName: "menucard.fill")!,
        UIImage(systemName: "location.magnifyingglass")!,
        UIImage(systemName: "person.fill")!,
        UIImage(systemName: "trash")!
    ]

    private var menuVC = UINavigationController(rootViewController: MenuAssembly().assemle())
    private var contactsVC = ContactsViewController()
    private var profileVC = ProfileViewController()
    private var trashVC = TrashViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        makeTabBarViews()
    }
    
    private func makeTabBarViews() {
        tabBar.tintColor = .systemBlue
        tabBar.backgroundColor = .white
        setViewControllers([menuVC, contactsVC, profileVC, trashVC], animated: false)
        
        guard let items = self.tabBar.items else { return }
        
        for i in 0..<items.count {
            items[i].title = titles[i]
            items[i].image = images[i]
        }
    }
    
}

