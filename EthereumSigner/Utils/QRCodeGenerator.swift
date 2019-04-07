//
//  QRCodeGenerator.swift
//  EthereumSigner
//
//  Created by OMER YASIN KOLKANAT on 7.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import UIKit

class QRCodeGenerator {
    static let shared = QRCodeGenerator()
    
    func generateQRCode(message: Data) -> UIImage? {
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(message, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}
