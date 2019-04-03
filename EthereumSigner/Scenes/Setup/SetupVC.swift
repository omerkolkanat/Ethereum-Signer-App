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
        guard let privateKey = privateKeyTextField.text else { return }
        model.setPrivateKey(key: privateKey)
    }
}

extension SetupVC: SetupViewModelProtocol {
    func didSetup() {
        print("didSetup")
    }
}
