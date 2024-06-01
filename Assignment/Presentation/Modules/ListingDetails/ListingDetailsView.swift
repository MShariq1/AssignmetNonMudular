//
//  ListingDetailsView.swift
//  Assignment
//
//  Created by M.Shariq Hasnain on 31/05/2024.
//

import UIKit

class ListingDetailsView: UIViewController {

    @IBOutlet weak var lblWebpage: UILabel!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblUniName: UILabel!
    
    var presenter: ViewToPresenterListingDetailsProtocol?
    var data: ListingsModel?
    var refresh: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
    }
    
    func setupData() {
        navigationItem.title = "Listing Details"
        lblUniName.text = data?.name
        lblState.text = data?.stateProvince
        lblCountry.text = data?.country
        lblCountryCode.text = data?.alphaTwoCode
        lblWebpage.text = data?.webPages.first
    }
    
    @IBAction func refreshList() {
        presenter?.refreshListings(navigationController: navigationController!, refresh: self.refresh)
    }

}
