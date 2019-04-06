//
//  SignVC.swift
//  EthereumSigner
//
//  Created by OMER YASIN KOLKANAT on 4.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import UIKit

class SignVC: UIViewController {
    
    fileprivate let model = SignViewModel()
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        title = "Signing"
        model.delegate = self
        hideKeyboardWhenTappedAround()
    }
    @IBAction func signButtonTapped(_ sender: Any) {
        model.signMessage(message: messageTextField.text ?? "")
    }
    
}

extension SignVC: SignViewModelProtocol {
    func didSignMessage() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let signatureVC = storyboard.instantiateViewController(withIdentifier: "SignatureVC") as? SignatureVC {
            signatureVC.message = messageTextField.text
            self.navigationController?.pushViewController(signatureVC, animated: true)
        }
    }
    
    func didFail() {
        
    }
    
}
