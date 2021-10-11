//
//  StringFormatter.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/9/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation
import UIKit

internal func formatAttributedString(string: String, range: String, attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
    let stringToFormat = (string as NSString).range(of: range)
    let attributedString = NSMutableAttributedString.init(string: string)
    attributedString.addAttributes(attributes, range: stringToFormat)
    return attributedString
}

