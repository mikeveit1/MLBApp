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
    private var innings: [Inning] = []
    
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
        configureLabel(label: teamsLabel, color: Colors.textColor, font: Fonts.mediumFontBold, data: "\(score.awayTeamName) at \(score.homeTeamName)")
        configureLabel(label: statusLabel, color: Colors.textColor, font: Fonts.mediumFont, data: getGameStatus(score: score))
        configureLabel(label: venueLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(score.venueName) - \(score.venueCity), \(score.venueState)")
        configureBoxScoreStackView(score: score)
    }
    
    private func setUpViews() {
        configureView()
    }
    
    private func configureView() {
        self.backgroundColor = Colors.backgroundColor
        self.addSubview(mainStackView)
        configureMainStackView()
    }
    
    private func configureMainStackView() {
        mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainStackView.addArrangedSubview(teamsLabel)
        mainStackView.addArrangedSubview(venueLabel)
        mainStackView.addArrangedSubview(statusLabel)
        mainStackView.addArrangedSubview(boxScoreStackView)
    }
    
    private func configureBoxScoreStackView(score: ScoreDisplay) {
        boxScoreStackView.addArrangedSubview(teamStackView)
        configureTeamStackView(score: score)
        boxScoreStackView.addArrangedSubview(inningStackView)
        configureInningsStackView(score: score)
        boxScoreStackView.addArrangedSubview(runsHitsErrorsStackView)
        configureRunsHitsErrorsStackView(score: score)
        boxScoreStackView.layer.borderColor = Colors.textColor.cgColor
        boxScoreStackView.layer.borderWidth = borderWidth
    }
    
    private func configureTeamStackView(score: ScoreDisplay) {
        teamStackView.addArrangedSubview(spacerLabel)
        teamStackView.addArrangedSubview(awayAbbreviationLabel)
        teamStackView.addArrangedSubview(homeAbbreviationLabel)
        configureLabel(label: spacerLabel, color: Colors.backgroundColor, font: Fonts.mediumFont, data: " ")
        configureLabel(label: awayAbbreviationLabel, color: Colors.textColor, font: Fonts.mediumFont, data: score.awayTeamAbbreviation)
        configureLabel(label: homeAbbreviationLabel, color: Colors.textColor, font: Fonts.mediumFont, data: score.homeTeamAbbreviation)
        teamStackView.leadingAnchor.constraint(equalTo: boxScoreStackView.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configureInningsStackView(score: ScoreDisplay) {
        for inning in score.innings {
            let numLabel = UILabel()
            let awayRunsLabel = UILabel()
            let homeRunsLabel = UILabel()
            let currentInningStackView = UIStackView()
            currentInningStackView.axis = .vertical
            currentInningStackView.distribution = .fill
            currentInningStackView.spacing = 10
            configureLabel(label: numLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(inning.num)")
            configureLabel(label: awayRunsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(inning.away.runs ?? 0)")
            configureLabel(label: homeRunsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(inning.home.runs ?? 0)")
            currentInningStackView.addArrangedSubview(numLabel)
            currentInningStackView.addArrangedSubview(awayRunsLabel)
            currentInningStackView.addArrangedSubview(homeRunsLabel)
            inningStackView.addArrangedSubview(currentInningStackView)
        }
    }
    
    private func configureRunsHitsErrorsStackView(score: ScoreDisplay) {
        runsHitsErrorsStackView.addArrangedSubview(totalRunsStackView)
        configureTotalRunsStackView(score: score)
        runsHitsErrorsStackView.addArrangedSubview(totalHitsStackView)
        configureTotalHitsStackView(score: score)
        runsHitsErrorsStackView.addArrangedSubview(totalErrorsStackView)
        configureTotalErrorsStackView(score: score)
        runsHitsErrorsStackView.trailingAnchor.constraint(equalTo: boxScoreStackView.trailingAnchor, constant: -20).isActive = true
    }
    
    private func configureTotalRunsStackView(score: ScoreDisplay) {
        totalRunsStackView.addArrangedSubview(runsLabel)
        configureLabel(label: runsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "R")
        totalRunsStackView.addArrangedSubview(awayRunsLabel)
        configureLabel(label: awayRunsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(score.awayTeamRuns)")
        totalRunsStackView.addArrangedSubview(homeRunsLabel)
        configureLabel(label: homeRunsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(score.homeTeamRuns)")
    }
    
    private func configureTotalHitsStackView(score: ScoreDisplay) {
        totalHitsStackView.addArrangedSubview(hitsLabel)
        configureLabel(label: hitsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "H")
        totalHitsStackView.addArrangedSubview(awayHitsLabel)
        configureLabel(label: awayHitsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(score.awayTeamHits)")
        totalHitsStackView.addArrangedSubview(homeHitsLabel)
        configureLabel(label: homeHitsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(score.homeTeamHits)")
    }
    
    private func configureTotalErrorsStackView(score: ScoreDisplay) {
        totalErrorsStackView.addArrangedSubview(errorsLabel)
        configureLabel(label: errorsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "E")
        totalErrorsStackView.addArrangedSubview(awayErrorsLabel)
        configureLabel(label: awayErrorsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(score.awayTeamErrors)")
        totalErrorsStackView.addArrangedSubview(homeErrorsLabel)
        configureLabel(label: homeErrorsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(score.homeTeamErrors)")
    }
    
    public func configureLabel(label: UILabel, color: UIColor, font: UIFont, data: String) {
        label.textColor = color
        label.font = font
        label.text = data
    }
    
    let mainStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .equalSpacing
        view.spacing = 10
        return view
    }()
    
    let teamsLabel: UILabel = {
        return UILabel()
    }()
    
    let statusLabel: UILabel = {
        return UILabel()
    }()
    
    let venueLabel: UILabel = {
        return UILabel()
    }()
    
    let boxScoreStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 20
        return view
    }()
    
    let teamStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.spacing = 0
        return view
    }()
    
    let spacerLabel: UILabel = {
        return UILabel()
    }()
    
    let awayAbbreviationLabel: UILabel = {
        return UILabel()
    }()
    
    let homeAbbreviationLabel: UILabel = {
        return UILabel()
    }()
    
    let inningStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    let totalRunsStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    let runsLabel: UILabel = {
        return UILabel()
    }()
    
    let awayRunsLabel: UILabel = {
        return UILabel()
    }()
    
    let homeRunsLabel: UILabel = {
        return UILabel()
    }()
    
    let totalHitsStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    let hitsLabel: UILabel = {
        return UILabel()
    }()
    
    let awayHitsLabel: UILabel = {
        return UILabel()
    }()
    
    let homeHitsLabel: UILabel = {
        return UILabel()
    }()
    
    let totalErrorsStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    let errorsLabel: UILabel = {
        return UILabel()
    }()
    
    let awayErrorsLabel: UILabel = {
        return UILabel()
    }()
    
    let homeErrorsLabel: UILabel = {
        return UILabel()
    }()
    
    let runsHitsErrorsStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    //box score stack view - horizontal
        //team stack view - vertical
            //team names
        //inning stack view - vertical
            //score for that inning
        //total runs stack view - vertical
            //total runs for the game
        //total hits stack view - vertical
            //total hits for the game
        //total errors stack view - vertical 
            //total erros for the game
    
}
