//
//  ListingDetailsRouter.swift
//  Assignment
//
//  Created by M.Shariq Hasnain on 31/05/2024.
//

import UIKit

protocol PresenterToRouterListingDetailsProtocol: AnyObject {
    static func createModule() -> ListingDetailsView
    func navigateBack(navigationController:UINavigationController, refresh: (() -> Void)?)
}

class ListingDetailsRouter: PresenterToRouterListingDetailsProtocol {
     
    static func createModule() -> ListingDetailsView {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "ListingDetailsView") as! ListingDetailsView
        
        let router:PresenterToRouterListingDetailsProtocol = ListingDetailsRouter()
        let presenter: ViewToPresenterListingDetailsProtocol = ListingDetailsPresenter()
        
        view.presenter = presenter
        presenter.router = router
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func navigateBack(navigationController:UINavigationController, refresh: (() -> Void)?) {
        refresh?()
        navigationController.popViewController(animated: true)
        
    }
    
}
