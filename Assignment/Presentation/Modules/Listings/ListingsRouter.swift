//
//  ListingsRouter.swift
//  Assignment
//
//  Created by M.Shariq Hasnain on 31/05/2024.
//

import UIKit

protocol PresenterToRouterListingsProtocol: AnyObject {
    static func createModule() -> ListingsView
    func pushToListingDetails(navigationController:UINavigationController, data: ListingsModel, refresh: @escaping (() -> Void))
}

class ListingsRouter: PresenterToRouterListingsProtocol {
    
    static func createModule() -> ListingsView {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "ListingsView") as! ListingsView
        
        let presenter: ViewToPresenterListingsProtocol & InteractorToPresenterListingsProtocol = ListingsPresenter()
        let interactor: PresenterToInteractorListingsProtocol = ListingsInteractor()
        let router:PresenterToRouterListingsProtocol = ListingsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToListingDetails(navigationController:UINavigationController, data: ListingsModel, refresh: @escaping (() -> Void)) {
        
        let convo = ListingDetailsRouter.createModule()
        convo.data = data
        convo.refresh = refresh
        navigationController.pushViewController(convo,animated: true)
        
    }
    
}
