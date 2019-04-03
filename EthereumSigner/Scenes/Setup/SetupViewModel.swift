//
//  SetupViewModel.swift
//  EthereumSigner
//
//  Created by OMER YASIN KOLKANAT on 3.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import Foundation

protocol SetupViewModelProtocol: class {
    func didSetup()
}

class SetupViewModel: NSObject {
    weak var delegate: SetupViewModelProtocol?
    
    func setPrivateKey(key: String) {
        delegate?.didSetup()
    }
}
