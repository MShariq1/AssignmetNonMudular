//
//  ListingsInteractor.swift
//  Assignment
//
//  Created by M.Shariq Hasnain on 31/05/2024.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

protocol PresenterToInteractorListingsProtocol: AnyObject {
    var presenter:InteractorToPresenterListingsProtocol? {get set}
    func callApi()
}

class ListingsInteractor: PresenterToInteractorListingsProtocol{
    
    var presenter: InteractorToPresenterListingsProtocol?
    
    
    func callApi() {
        NetworkManager.sharedInstance.callAPi(urlString: listingsURL, methodType: .get) { json, error, localData  in
            if error == nil {
                if localData != nil {
                    let model = List<ListingsModel>()
                    for university in localData! {
                        model.append(university)
                    }
                    self.presenter?.listingsApiSuccess(data: model)
                    return
                }
                let model = List<ListingsModel>()
                for jsonData in json?.arrayValue ?? [] {
                    let university = ListingsModel(data: jsonData.rawValue as! [String : Any])
                    model.append(university)
                    RealmHelper.saveObject(object: university)
                }
                self.presenter?.listingsApiSuccess(data: model)
            } else {
                self.presenter?.listingsApiError(errMsg: error?.localizedDescription ?? "")
            }
        }
        
    }
    
    
}

