//
//  ListingDetailsPresenter.swift
//  Assignment
//
//  Created by M.Shariq Hasnain on 31/05/2024.
//

import UIKit

protocol ViewToPresenterListingDetailsProtocol: AnyObject{
    var view: PresenterToViewListingsProtocol? {get set}
    var router: PresenterToRouterListingDetailsProtocol? {get set}
    func refreshListings(navigationController:UINavigationController, refresh: (() -> Void)?)

}

class ListingDetailsPresenter:ViewToPresenterListingDetailsProtocol {
    var view: PresenterToViewListingsProtocol?
    
    var router: PresenterToRouterListingDetailsProtocol?
    
    
    func refreshListings(navigationController:UINavigationController, refresh: (() -> Void)?) {
        router?.navigateBack(navigationController:navigationController, refresh: refresh)
    }

}
