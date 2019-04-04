//
//  AccountVCViewController.swift
//  EthereumSigner
//
//  Created by OMER YASIN KOLKANAT on 4.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {

    @IBOutlet weak var addressValueLabel: UILabel!
    @IBOutlet weak var balanceValueLabel: UILabel!
    
    var address: String!
    var balance: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Account"
        addressValueLabel.text = address
        balanceValueLabel.text = balance
    }

}
