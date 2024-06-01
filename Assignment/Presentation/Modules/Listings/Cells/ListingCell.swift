//
//  ListingCell.swift
//  Assignment
//
//  Created by M.Shariq Hasnain on 31/05/2024.
//

import UIKit

class ListingCell: UITableViewCell {

    @IBOutlet weak var btnGo: UIButton!
    @IBOutlet weak var lblUniState: UILabel!
    @IBOutlet weak var lblUniName: UILabel!
    @IBOutlet weak var vuMain: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupUI() {
        vuMain.slightRound()
        vuMain.addDropShadow()
    }
    
    func setupData(data: ListingsModel) {
        lblUniName.text = data.name
        lblUniState.text = data.stateProvince == "" ? data.country : data.stateProvince
    }
}
