//
//  LabelFormatter.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/10/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation
import UIKit

struct Fonts {
    public static let smallFont = UIFont.systemFont(ofSize: 13)
    public static let smallFontBold = UIFont.boldSystemFont(ofSize: 13)
    public static let mediumFont = UIFont.systemFont(ofSize: 17)
    public static let mediumFontBold =  UIFont.boldSystemFont(ofSize: 17)
    public static let largeFont = UIFont.systemFont(ofSize: 28)
    public static let largeFontBold = UIFont.boldSystemFont(ofSize: 28)
}

internal func configureLabel(label: UILabel, color: UIColor, font: UIFont, data: String) {
    label.textColor = color
    label.font = font
    label.text = data
}
