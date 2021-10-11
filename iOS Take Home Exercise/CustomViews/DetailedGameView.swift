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
        configureBoxScoreLabelStackView(score: score)
        configureAwayTeamBoxScoreStackView(score: score)
        configureHomeTeamBoxScoreStackView(score: score)
    }
    
    private func setUpViews() {
        configureView()
    }
    
    private func configureView() {
        self.backgroundColor = Colors.backgroundColor
        self.layer.cornerRadius = cornerRadiusValue
        self.addSubview(mainStackView)
        configureMainStackView()
    }
    
    private func configureMainStackView() {
        constrainMainStackView()
        mainStackView.addArrangedSubview(teamsLabel)
        mainStackView.addArrangedSubview(venueLabel)
        mainStackView.addArrangedSubview(statusLabel)
        mainStackView.addArrangedSubview(boxScoreLabelStackView)
        mainStackView.addArrangedSubview(awayTeamBoxScoreStackView)
        mainStackView.addArrangedSubview(homeTeamBoxScoreStackView)
    }
    
    private func constrainMainStackView() {
        mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        mainStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    private func configureBoxScoreLabelStackView(score: ScoreDisplay) {
        for inning in score.innings {
            let inningsLabel = UILabel()
            configureLabel(label: inningsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(inning.num)")
            boxScoreLabelStackView.addArrangedSubview(inningsLabel)
        }
        boxScoreLabelStackView.addArrangedSubview(runsLabel)
        boxScoreLabelStackView.addArrangedSubview(hitsLabel)
        boxScoreLabelStackView.addArrangedSubview(errorsLabel)
        configureLabel(label: runsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "R")
        configureLabel(label: hitsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "H")
        configureLabel(label: errorsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "E")
        constrainBoxScoreLabelStackView()
    }
    
    private func constrainBoxScoreLabelStackView() {
        boxScoreLabelStackView.trailingAnchor.constraint(equalTo: awayTeamBoxScoreStackView.trailingAnchor).isActive = true
    }
    
    private func configureAwayTeamBoxScoreStackView(score: ScoreDisplay) {
        awayTeamBoxScoreStackView.addArrangedSubview(awayAbbreviationLabel)
        configureLabel(label: awayAbbreviationLabel, color: Colors.textColor, font: Fonts.mediumFont, data: score.awayTeamAbbreviation)
        for inning in score.innings {
            let inningsLabel = UILabel()
            configureLabel(label: inningsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(inning.away.runs ?? 0)")
            awayTeamBoxScoreStackView.addArrangedSubview(inningsLabel)
        }
        awayTeamBoxScoreStackView.addArrangedSubview(awayRunsLabel)
        awayTeamBoxScoreStackView.addArrangedSubview(awayHitsLabel)
        awayTeamBoxScoreStackView.addArrangedSubview(awayErrorsLabel)
        configureLabel(label: awayRunsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(score.awayTeamRuns)")
        configureLabel(label: awayHitsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(score.awayTeamHits)")
        configureLabel(label: awayErrorsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(score.awayTeamErrors)")
    }
    
    private func configureHomeTeamBoxScoreStackView(score: ScoreDisplay) {
        homeTeamBoxScoreStackView.addArrangedSubview(homeAbbreviationLabel)
        configureLabel(label: homeAbbreviationLabel, color: Colors.textColor, font: Fonts.mediumFont, data: score.homeTeamAbbreviation)
        for inning in score.innings {
            let inningsLabel = UILabel()
            configureLabel(label: inningsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(inning.home.runs ?? 0)")
            homeTeamBoxScoreStackView.addArrangedSubview(inningsLabel)
        }
        homeTeamBoxScoreStackView.addArrangedSubview(homeRunsLabel)
        homeTeamBoxScoreStackView.addArrangedSubview(homeHitsLabel)
        homeTeamBoxScoreStackView.addArrangedSubview(homeErrorsLabel)
        configureLabel(label: homeRunsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(score.homeTeamRuns)")
        configureLabel(label: homeHitsLabel, color: Colors.textColor, font: Fonts.mediumFont, data: "\(score.homeTeamHits)")
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
    
    let boxScoreLabelStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    let runsLabel: UILabel = {
        return UILabel()
    }()
    
    let hitsLabel: UILabel = {
        return UILabel()
    }()
    
    let errorsLabel: UILabel = {
        return UILabel()
    }()
    
    let awayTeamBoxScoreStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    let awayAbbreviationLabel: UILabel = {
        return UILabel()
    }()
    
    let awayRunsLabel: UILabel = {
        return UILabel()
    }()
    
    let awayHitsLabel: UILabel = {
        return UILabel()
    }()
    
    let awayErrorsLabel: UILabel = {
        return UILabel()
    }()
    
    let homeTeamBoxScoreStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .fill
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    let homeAbbreviationLabel: UILabel = {
        return UILabel()
    }()
    
    let homeRunsLabel: UILabel = {
        return UILabel()
    }()
    
    let homeHitsLabel: UILabel = {
        return UILabel()
    }()
    
    let homeErrorsLabel: UILabel = {
        return UILabel()
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
