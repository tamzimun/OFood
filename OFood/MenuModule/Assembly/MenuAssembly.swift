//
//  MenuAssembly.swift
//  OFood
//
//  Created by tamzimun on 18.10.2022.
//

import UIKit

final class MenuAssembly {
    func assemle() -> UIViewController {
        let menuDataDisplayManager = MenuDataDisplayManager()
        let bannerDataDisplayManager = BannerDataDisplayManager()
        let viewController = MenuViewController()
        let presenter = MenuPresenter()
        let network: Networkable = NetworkManager.shared
        let interactor = MenuInteractor(network: network)
        let router = MenuRouter()
        
        viewController.menuDataDisplayManager = menuDataDisplayManager
        viewController.bannersDataDisplayManager = bannerDataDisplayManager
        viewController.output = presenter
        presenter.view = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.output = presenter
        return viewController
    }
}
