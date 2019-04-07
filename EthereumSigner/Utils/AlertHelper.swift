//
//  AlertHelper.swift
//  EthereumSigner
//
//  Created by OMER YASIN KOLKANAT on 7.04.2019.
//  Copyright © 2019 Omer Kolkanat. All rights reserved.
//

import Foundation
import UIKit

class AlertHelper: NSObject {
    
    enum AlertMessage: String {
        case ValidationSuccessMessage = "Signature is valid"
        case ValidationFailMessage = "Signature is invalid"
    }
    
    enum AlertTitle: String {
        case Success = "Success"
        case Warning = "Warning"
        case Error = "Error"
    }
    
    static func showAlert(title: String, message: String, fromController: UIViewController) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK",
                                                style: UIAlertAction.Style.default,
                                                handler: nil))
        fromController.present(alertController, animated: true, completion: nil)
    }
    
    static func showValidationSuccessMessage(fromController: UIViewController) {
        showAlert(title: AlertTitle.Success.rawValue,
                  message: AlertMessage.ValidationSuccessMessage.rawValue,
                  fromController: fromController)
    }
    
    static func showValidationFailMessage(fromController: UIViewController) {
        showAlert(title: AlertTitle.Error.rawValue,
                  message: AlertMessage.ValidationFailMessage.rawValue,
                  fromController: fromController)
    }
}
