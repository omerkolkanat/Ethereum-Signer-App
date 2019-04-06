//
//  SignatureViewModel.swift
//  EthereumSigner
//
//  Created by OMER YASIN KOLKANAT on 6.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import Foundation
import Web3swift

protocol SignatureViewModelProtocol: class {
    func didSignPersonalMessage(signedData: Data)
}

class SignatureViewModel: NSObject {
    weak var delegate: SignatureViewModelProtocol?
    
    func signPersonalMessage(message: String) {
        let web3Rinkeby = Web3.InfuraRinkebyWeb3()
        guard let privateKeyData = Data.fromHex("0x85f2f20a9db5c18a656480a99d4cb1feef5e7eba7c9dff1213fb52aed60881dc") else { return }
        let keystore = try! EthereumKeystoreV3(privateKey: privateKeyData)
        let keystoreManager = KeystoreManager([keystore!])
        web3Rinkeby.addKeystoreManager(keystoreManager)
        let ethAddress = keystoreManager.addresses![0]
        do {
            let signedData = try web3Rinkeby.personal.signPersonalMessage(message: message.data(using: .utf8)!, from: ethAddress)
            delegate?.didSignPersonalMessage(signedData: signedData)
        } catch {
            print(error)
        }
    }
}
