//
//  SetupViewModel.swift
//  EthereumSigner
//
//  Created by OMER YASIN KOLKANAT on 3.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import Foundation
import Web3swift

protocol SetupViewModelProtocol: class {
    func didSetup(address: String, balance: String)
    func didFail()
    func showLoader(shouldShow: Bool)
}

class SetupViewModel: NSObject {
    weak var delegate: SetupViewModelProtocol?
    
    func getBalanceAndAddress(privateKey: String) {
        delegate?.showLoader(shouldShow: true)
        if let privateKeyData = Data.fromHex(privateKey) {
            guard let newWallet = try? EthereumKeystoreV3(privateKey: privateKeyData) else { return }
            let web3Rinkeby = Web3.InfuraRinkebyWeb3()
            guard let ethAddress = newWallet.getAddress() else { return }
            guard let balanceResult = try? web3Rinkeby.eth.getBalance(address: ethAddress) else { return }
            guard let balanceString = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .eth, decimals: 3) else { return }
            delegate?.didSetup(address: ethAddress.address, balance: balanceString)
        } else {
            delegate?.didFail()
        }
        delegate?.showLoader(shouldShow: false)
    }
}
