//
//  SignatureVC.swift
//  EthereumSigner
//
//  Created by OMER YASIN KOLKANAT on 4.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import UIKit
import Web3swift

class SignatureVC: UIViewController {
    fileprivate let model = SignatureViewModel()
    
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
        model.delegate = self
        model.signPersonalMessage(message: message)
    }
    
    func generateQRCode(message: Data) -> UIImage? {
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(message, forKey: "inputMessage")
            if let outputCIImage = filter.outputImage {
                let scaleX = qrCodeImageView.frame.size.width / outputCIImage.extent.width
                let scaleY = qrCodeImageView.frame.size.height / outputCIImage.extent.height
                let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            
                if let output = filter.outputImage?.transformed(by: transform) {
                    return UIImage(ciImage: output)
                }
            }
        }
        return nil
    }
}

extension SignatureVC: SignatureViewModelProtocol {
    func didSignPersonalMessage(signedData: Data) {
        qrCodeImageView.image = generateQRCode(message: signedData)
    }
}
