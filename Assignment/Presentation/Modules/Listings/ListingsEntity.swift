//
//  ListingsEntity.swift
//  Assignment
//
//  Created by M.Shariq Hasnain on 31/05/2024.
//

import RealmSwift

class ListingsModel: Object {
    
    @Persisted(primaryKey: true) var name: String = ""
    @Persisted var domains: List<String>
    @Persisted var webPages: List<String>
    @Persisted var alphaTwoCode: String
    @Persisted var stateProvince: String
    @Persisted var country: String

    override class func primaryKey() -> String? {
        return "name"
    }
    
    override init() {
        super.init()
    }
    
    init(data: [String: Any]) {
        name = data["name"] as? String ?? ""
        alphaTwoCode = data["alpha_two_code"] as? String ?? ""
        stateProvince = data["state-province"] as? String ?? ""
        country = data["country"] as? String ?? ""
        domains = data["domains"] as? List<String> ?? List()
        webPages = data["web_pages"] as? List<String> ?? List()
    }
}
