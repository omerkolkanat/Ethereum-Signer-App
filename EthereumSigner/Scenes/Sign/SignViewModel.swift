//
//  File.swift
//  EthereumSigner
//
//  Created by OMER YASIN KOLKANAT on 4.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import Foundation
import Web3swift

protocol SignViewModelProtocol: class {
    func didSignMessage()
    func didFail()
}

class SignViewModel: NSObject {
    weak var delegate: SignViewModelProtocol?
    
    func signMessage(message: String) {
        
        delegate?.didSignMessage()
    }
}
