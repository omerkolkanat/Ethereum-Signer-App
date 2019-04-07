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
import Web3swift
import secp256k1_swift

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

    }
    
    @IBAction func validateButtonTapped(_ sender: Any) {
        readerVC.delegate = self
        
        readerVC.modalPresentationStyle = .formSheet
        present(readerVC, animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

extension ValidateVC: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        if let signature = Data(base64Encoded: result.value),
            let unMarshalledSign = SECP256K1.unmarshalSignature(signatureData: signature) {
            let web3Rinkeby = Web3.InfuraRinkebyWeb3()
            print("V = " + String(unMarshalledSign.v))
            print("R = " + Data(unMarshalledSign.r).toHexString())
            print("S = " + Data(unMarshalledSign.s).toHexString())
            let signer = try? web3Rinkeby.personal.ecrecover(personalMessage: validateTextField.text!.data(using: .utf8)!, signature: signature)
            if (signer?.address == Web3Manager.sharedInstance.walletAddress) {
                print("Verification succeed")
            } else {
                print("Verification failed")
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
}

