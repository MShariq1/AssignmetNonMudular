//
//  ListingsView.swift
//  Assignment
//
//  Created by M.Shariq Hasnain on 31/05/2024.
//

import UIKit
import RealmSwift

protocol PresenterToViewListingsProtocol: AnyObject {
    func listingsApiSuccess(data: List<ListingsModel>)
    func listingsApiError(errMsg: String)
}

class ListingsView: UIViewController {

    @IBOutlet weak var table: UITableView!
    var data = List<ListingsModel>()
    var presenter: ViewToPresenterListingsProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        self.navigationController?.navigationBar.show()
        navigationItem.title = "Listings"
        table.register(UINib(nibName: "ListingCell", bundle: nil), forCellReuseIdentifier: "ListingCell")
        getUniversities()
    }
    
    func getUniversities() {
        presenter?.getUniversities()
    }

}

//MARK: TABLE VIEW
extension ListingsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: "ListingCell") as? ListingCell else {return UITableViewCell()}
        cell.setupData(data: self.data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showNextView(navigationController: navigationController!, data: self.data[indexPath.row])
    }
}

//MARK: Conform to presenter protocol
extension ListingsView: PresenterToViewListingsProtocol{
    
    func listingsApiSuccess(data: List<ListingsModel>) {
        self.data = data
        table.reloadWithScroll()
    }
    
    func listingsApiError(errMsg: String) {
        let alert = UIAlertController(title: "Alert", message: errMsg.debugDescription, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
