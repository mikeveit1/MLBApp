//
//  DetailedGameView.swift
//  iOS Take Home Exercise
//
//  Created by Michael Veit on 10/10/21.
//  Copyright © 2021 Lewanda, David. All rights reserved.
//

import Foundation
import UIKit

class DetailedGameView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    
    public override func prepareForInterfaceBuilder() {
        setUpViews()
    }
    
    public func setData(score: ScoreDisplay) {
        configureLabel(label: teamsLabel, color: Colors.separatorColor, font: Fonts.mediumFont, data: "\(score.awayTeamName) at \(score.homeTeamName)")
    }
    
    private func setUpViews() {
        configureView()
    }
    
    private func configureView() {
        self.isHidden = true 
        self.backgroundColor = Colors.textColor
        self.layer.cornerRadius = cornerRadiusValue
        self.addSubview(mainStackView)
        self.addSubview(closeButton)
        configureMainStackView()
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
       // configureCloseButton()
    }
    
    @objc func closeButtonPressed() {
        self.isHidden = true
    }
    
    private func configureMainStackView() {
        constrainMainStackView()
        mainStackView.addArrangedSubview(teamsLabel)
    }
    
    private func constrainMainStackView() {
        mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    public func configureLabel(label: UILabel, color: UIColor, font: UIFont, data: String) {
        label.textColor = color
        label.font = font
        label.text = data
    }
    
    let closeButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "xmark"), for: .normal)
        view.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        view.clipsToBounds = true
        view.layer.cornerRadius = view.frame.width / 2
        view.backgroundColor = .red
        view.tintColor = .green
        return view
    }()
    
    let mainStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.backgroundColor = Colors.backgroundColor
        //mainStackView.layer.cornerRadius = cornerRadiusValue
        view.alignment = .center
        view.distribution = .equalSpacing
        view.spacing = 2
        //constrainMainStackView()
        return view
    }()
    
    let teamsLabel: UILabel = {
        return UILabel()
    }()
    
}
