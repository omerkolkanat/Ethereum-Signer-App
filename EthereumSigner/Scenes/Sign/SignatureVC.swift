//
//  SignatureVC.swift
//  EthereumSigner
//
//  Created by OMER YASIN KOLKANAT on 4.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import UIKit

class SignatureVC: UIViewController {
    
    var message: String!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        title = "Signature"
        messageLabel.text = "Message: \(message ?? "")"
        if let signedData = Web3Manager.sharedInstance.signPersonalMessage(message: message) {
            qrCodeImageView.image = QRCodeGenerator.shared.generateQRCode(message: signedData)
        }
    }
}
