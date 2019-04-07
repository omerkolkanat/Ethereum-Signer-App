//
//  VerifyVC.swift
//  EthereumSigner
//
//  Created by OMER YASIN KOLKANAT on 4.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import UIKit
import QRCodeReader
import AVFoundation

class ValidateVC: UIViewController {
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showSwitchCameraButton = false
            $0.showTorchButton = false
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    @IBOutlet weak var validateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Validate"
        hideKeyboardWhenTappedAround()
        validateTextField.delegate = self
        validateTextField.placeholder = "Message"
    }
    
    @IBAction func validateButtonTapped(_ sender: Any) {
        presentQRCodeVC()
    }
    
    func presentQRCodeVC() {
        readerVC.delegate = self
        
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

extension ValidateVC: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        
        guard let message = validateTextField.text else { return }
        if Web3Manager.sharedInstance.validatePersonalMessage(message: message, qrResultString: result.value) {
            self.dismiss(animated: true) {
                AlertHelper.showValidationSuccessMessage(fromController: self)
            }
        } else {
            self.dismiss(animated: true) {
                AlertHelper.showValidationFailMessage(fromController: self)
            }
        }
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
}

extension ValidateVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        presentQRCodeVC()
        return true
    }
}
