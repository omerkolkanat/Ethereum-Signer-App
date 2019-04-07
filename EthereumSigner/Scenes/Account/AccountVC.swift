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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Account"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        if let privateKey = UserDefaults.standard.string(forKey: "privateKey") {
            Web3Manager.sharedInstance.privateKey = privateKey
            if let ethWallet = Web3Manager.sharedInstance.getBalanceAndAddress() {
                addressValueLabel.text = ethWallet.address
                balanceValueLabel.text = ethWallet.balance
            }
        }
    }
}
