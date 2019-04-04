//
//  ViewController.swift
//  EthereumSigner
//
//  Created by OMER YASIN KOLKANAT on 3.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import UIKit

class SetupVC: UIViewController {

    @IBOutlet weak var privateKeyTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate let model = SetupViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.title = "Setup"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        hideKeyboardWhenTappedAround()
        model.delegate = self
        privateKeyTextField.placeholder = "Private Key"
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
//        guard let privateKey = privateKeyTextField.text else { return }
        
        self.model.getBalanceAndAddress(privateKey: "0x85f2f20a9db5c18a656480a99d4cb1feef5e7eba7c9dff1213fb52aed60881dc")
    }
}

extension SetupVC: SetupViewModelProtocol {
    func didFail() {
        print("error")
    }
    
    func showLoader(shouldShow: Bool) {
        if shouldShow {
            activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func didSetup(address: String, balance: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let accountVC = storyboard.instantiateViewController(withIdentifier: "AccountVC") as? AccountVC {
            accountVC.address = address
            accountVC.balance = balance
            self.navigationController?.pushViewController(accountVC, animated: true)
        }
    }
}
