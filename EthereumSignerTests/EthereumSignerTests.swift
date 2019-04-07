//
//  EthereumSignerTests.swift
//  EthereumSignerTests
//
//  Created by OMER YASIN KOLKANAT on 3.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import XCTest
@testable import EthereumSigner

class EthereumSignerTests: XCTestCase {

    func testGetBalanceAndAddressWithValidPrivateKey() {
        Web3Manager.sharedInstance.privateKey = "0x85f2f20a9db5c18a656480a99d4cb1feef5e7eba7c9dff1213fb52aed60881dc"
        let ethereumWallet = Web3Manager.sharedInstance.getBalanceAndAddress()
        XCTAssertNotNil(ethereumWallet?.address)
        XCTAssertNotNil(ethereumWallet?.balance)
        XCTAssertEqual(ethereumWallet?.address, "0xfC06fE59F38Bb7701833fc2f1c3e2e1D94F858B9")
    }
    
    func testGetBalanceAndAdressWithInvalidPrivateKey() {
        Web3Manager.sharedInstance.privateKey = "0x85f2f20a9db5c18a"
        let ethereumWallet = Web3Manager.sharedInstance.getBalanceAndAddress()
        XCTAssertNil(ethereumWallet)
    }
    
    func testSignAndVerifyPersonalMessage() {
        Web3Manager.sharedInstance.privateKey = "0x85f2f20a9db5c18a656480a99d4cb1feef5e7eba7c9dff1213fb52aed60881dc"
        if let signedData = Web3Manager.sharedInstance.signPersonalMessage(message: "hello"),
            let signedString = String(data: signedData, encoding: .utf8) {
            let validationResult = Web3Manager.sharedInstance.validatePersonalMessage(message: "hello", qrResultString: signedString)
            XCTAssertTrue(validationResult)
        }
    }
    
    func testSignAndVerifyPersonalMessageWithDifferentMessage() {
        Web3Manager.sharedInstance.privateKey = "0x85f2f20a9db5c18a656480a99d4cb1feef5e7eba7c9dff1213fb52aed60881dc"
        if let signedData = Web3Manager.sharedInstance.signPersonalMessage(message: "hello"),
            let signedString = String(data: signedData, encoding: .utf8) {
            let validationResult = Web3Manager.sharedInstance.validatePersonalMessage(message: "hi", qrResultString: signedString)
            XCTAssertFalse(validationResult)
        }
    }
    
    func testSignAndVerifyPersonalMessageWithDifferentAddress() {
        Web3Manager.sharedInstance.privateKey = "0x85f2f20a9db5c18a656480a99d4cb1feef5e7eba7c9dff1213fb52aed60881dc"
        if let signedData = Web3Manager.sharedInstance.signPersonalMessage(message: "hello"),
            let signedString = String(data: signedData, encoding: .utf8) {
            Web3Manager.sharedInstance.walletAddress = "0xfC06fE59F38Bb7701833fc2f1c3e2e1D94F858B8" //last value changed from 9 to 8
            let validationResult = Web3Manager.sharedInstance.validatePersonalMessage(message: "hello", qrResultString: signedString)
            XCTAssertFalse(validationResult)
        }
    }

}
