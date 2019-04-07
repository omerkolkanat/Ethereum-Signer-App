//
//  Web3Manager.swift
//  EthereumSigner
//
//  Created by OMER YASIN KOLKANAT on 7.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import Foundation
import Web3swift
import secp256k1_swift

class Web3Manager {
    static let sharedInstance = Web3Manager()

    var walletAddress: String?
    var privateKey: String?
    
    private let web3Rinkeby = Web3.InfuraRinkebyWeb3()
    
    func getBalanceAndAddress() -> EthereumWallet? {
        guard let privateKey = privateKey else { return nil }
        if let privateKeyData = Data.fromHex(privateKey) {
            guard let newWallet = try? EthereumKeystoreV3(privateKey: privateKeyData) else { return nil }
            guard let ethAddress = newWallet.getAddress() else { return nil }
            guard let balanceResult = try? web3Rinkeby.eth.getBalance(address: ethAddress) else { return nil }
            guard let balanceString = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .eth, decimals: 3) else { return nil }
            walletAddress = ethAddress.address
            return EthereumWallet(address: ethAddress.address, balance: balanceString + " ETH")
        }
        return nil
    }
    
    func signPersonalMessage(message: String) -> Data? {
        guard let privateKey = privateKey else { return nil }
        guard let privateKeyData = Data.fromHex(privateKey) else { return nil }
        guard let keystore = try? EthereumKeystoreV3(privateKey: privateKeyData) else { return nil }
        let keystoreManager = KeystoreManager([keystore])
        web3Rinkeby.addKeystoreManager(keystoreManager)
        guard let addresses = keystoreManager.addresses else { return nil }
        do {
            guard let messageData = message.data(using: .utf8) else { return nil }
            let signedData = try web3Rinkeby.personal.signPersonalMessage(message: messageData, from: addresses[0])
            let signedBase64Data = signedData.base64EncodedData()
            return signedBase64Data
        } catch {
            print(error)
            return nil
        }
    }
    
    func validatePersonalMessage(message: String, qrResultString: String) -> Bool {
        if let signature = Data(base64Encoded: qrResultString),
            let unMarshalledSign = SECP256K1.unmarshalSignature(signatureData: signature) {
            print("V = " + String(unMarshalledSign.v))
            print("R = " + Data(unMarshalledSign.r).toHexString())
            print("S = " + Data(unMarshalledSign.s).toHexString())
            guard let messageData = message.data(using: .utf8) else { return false }
            let signer = try? web3Rinkeby.personal.ecrecover(personalMessage: messageData, signature: signature)
            if (signer?.address == walletAddress) {
                return true
            } else {
                return false
            }
        }
        return false
    }
}

