//
//  SignVC.swift
//  EthereumSigner
//
//  Created by OMER YASIN KOLKANAT on 4.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import UIKit

class SignVC: UIViewController {
    
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        title = "Signing"
        hideKeyboardWhenTappedAround()
        messageTextField.delegate = self

    }
    @IBAction func signButtonTapped(_ sender: Any) {
        openSignatureVC()
    }
    
    func openSignatureVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let signatureVC = storyboard.instantiateViewController(withIdentifier: "SignatureVC") as? SignatureVC {
            signatureVC.message = messageTextField.text
            self.navigationController?.pushViewController(signatureVC, animated: true)
        }
    }
}

extension SignVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        openSignatureVC()
        return true
    }
}
