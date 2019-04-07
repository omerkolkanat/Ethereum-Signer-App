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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.title = "Setup"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        hideKeyboardWhenTappedAround()
        privateKeyTextField.delegate = self
        privateKeyTextField.placeholder = "Private Key"
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        openAccountVC()
    }
    
    func openAccountVC() {
        guard let privateKey = privateKeyTextField.text, !privateKey.isEmpty else { return }
        UserDefaults.standard.set(privateKey, forKey: "privateKey")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let accountVC = storyboard.instantiateViewController(withIdentifier: "AccountVC") as? AccountVC {
            let navigationController = UINavigationController(rootViewController: accountVC)
            self.navigationController?.present(navigationController, animated: true, completion: nil)
        }
    }
}

extension SetupVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        openAccountVC()
        return true
    }
}
