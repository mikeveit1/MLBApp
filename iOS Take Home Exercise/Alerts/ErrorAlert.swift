//
//  ErrorAlert.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/8/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func showErrorAlert(title: String, message:String ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: { action in
                                            self.dismiss(animated: true, completion: nil) })
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
