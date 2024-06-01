//
//  NetworkManager.swift
//  Assignment
//
//  Created by M.Shariq Hasnain on 31/05/2024.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkManager {
    var reachabilityManager: NetworkReachabilityManager?

    init() {
        // Initialize the reachability manager
        self.reachabilityManager = NetworkReachabilityManager()
        // Start listening for reachability changes
        self.reachabilityManager?.startListening()
      
    }
    deinit {
           // Stop listening for reachability changes when the object is deallocated
           self.reachabilityManager?.stopListening()
       }
    
    
    var Header:HTTPHeaders = ["Accept":"application/json",
                              "Content-Type": "application/json"]
    var alertWindow : UIWindow!
    
    static let sharedInstance = NetworkManager()
    
    
    class func isInternetConnected() -> Bool{
        return NetworkReachabilityManager()!.isReachable
    }
    
    func showAlertWithRetry(message: String, retryAction: @escaping () -> Void) {
           let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
           let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
               retryAction()
           }
           alert.addAction(retryAction)
        
            UIApplication.topViewController()?.present(alert, animated: true)
       }
    
    func callAPi(urlString: String,
                 methodType : HTTPMethodTypes,
                 param :[String : Any]? = nil,
                 header: [String : String]? = nil,
                 completion: @escaping (JSON?, Error?, [ListingsModel]?) -> ())
    {
        let encoding: ParameterEncoding! = JSONEncoding.default
        guard NetworkManager.isInternetConnected() else {
                 //no internet
            let localData = RealmHelper.getObjects(with: ListingsModel.self)
            if localData.count < 1 {
                showAlertWithRetry(message: "No internet connection. Please check your connection and try again.", retryAction: {
                    self.callAPi(urlString: urlString, methodType: methodType, param: param, header: header, completion: completion)
                })
                return
            }
            //local data
                 completion(nil, nil, localData)
                 return
             }
        
        let methodTypee: HTTPMethod = HTTPMethod(rawValue: methodType.rawValue)!
        NetworkLogger.log(url: urlString, type: methodTypee, param: param, header: Header)
        SwiftLoader.show(animated: true)
        
        Alamofire.request(urlString, method: methodTypee, parameters: param, encoding: encoding, headers:Header)
            .response { (response) in
                
                SwiftLoader.hide()
                NetworkLogger.log(response: response, data: response.data!)
                if let error = response.error {
                    completion(nil, error, nil)
                } else {
                    do {
                        
                        let json = try JSON(data: response.data!)
                        let status = response.response?.statusCode
                        if (200...299).contains(status!) {
                            completion(json, nil, nil)
                        }else {
                            UIApplication.topViewController()?.view.makeToast(json["error"].stringValue)
                        }
                    } catch {
                        UIApplication.topViewController()?.view.makeToast(error.localizedDescription)
                        completion(nil, error, nil)
                    }
                }
            }
    }
    

    
}
