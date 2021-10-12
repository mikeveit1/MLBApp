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
        configureLabel(label: teamsLabel, color: labelTextColor, font: Fonts.mediumLargeFontBold, data: "\(score.awayTeamName) @ \(score.homeTeamName)")
        configureLabel(label: dateLabel, color: labelTextColor, font: Fonts.mediumFont, data: getCurrentDateString(date: score.officialDate, format: monthDayYearFormat))
        configureLabel(label: venueLabel, color: labelTextColor, font: Fonts.mediumFont, data: "\(score.venueName) - \(score.venueCity), \(score.venueState)")
        configureBoxScoreContainer(score: score)
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
        mainStackView.addArrangedSubview(dateLabel)
        mainStackView.addArrangedSubview(boxScoreLabel)
        configureLabel(label: boxScoreLabel, color: labelTextColor, font: Fonts.mediumFontBold, data: "Box Score:")
        mainStackView.addArrangedSubview(boxScoreContainer)
    }
    
    private func configureBoxScoreContainer(score: ScoreDisplay) {
        boxScoreContainer.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor).isActive = true
        boxScoreContainer.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor).isActive = true
        boxScoreContainer.addSubview(boxScoreStackView)
        boxScoreContainer.backgroundColor = Colors.separatorColor
        configureBoxScoreStackView(score: score)
    }
    
    private func configureBoxScoreStackView(score: ScoreDisplay) {
        boxScoreStackView.backgroundColor = .clear
        boxScoreStackView.addArrangedSubview(teamStackView)
        configureTeamStackView(score: score)
        boxScoreStackView.addArrangedSubview(inningStackView)
        configureInningsStackView(score: score)
        boxScoreStackView.addArrangedSubview(runsHitsErrorsStackView)
        configureRunsHitsErrorsStackView(score: score)
        boxScoreStackView.leadingAnchor.constraint(equalTo: boxScoreContainer.leadingAnchor, constant: 10).isActive = true
        boxScoreStackView.rightAnchor.constraint(equalTo: boxScoreContainer.rightAnchor, constant: -10).isActive = true
        boxScoreStackView.topAnchor.constraint(equalTo: boxScoreContainer.topAnchor, constant: 10).isActive = true
        boxScoreStackView.bottomAnchor.constraint(equalTo: boxScoreContainer.bottomAnchor, constant: -10).isActive = true
    }
    
    private func configureTeamStackView(score: ScoreDisplay) {
        teamStackView.addArrangedSubview(spacerLabel)
        teamStackView.addArrangedSubview(awayAbbreviationLabel)
        teamStackView.addArrangedSubview(homeAbbreviationLabel)
        configureLabel(label: spacerLabel, color: Colors.backgroundColor, font: Fonts.mediumFont, data: " ")
        configureLabel(label: awayAbbreviationLabel, color: labelTextColor, font: Fonts.mediumFontBold, data: score.awayTeamAbbreviation)
        configureLabel(label: homeAbbreviationLabel, color: labelTextColor, font: Fonts.mediumFontBold, data: score.homeTeamAbbreviation)
    }
    
    private func formatRunsLabels(awayRuns: Int, homeRuns: Int, awayLabel: UILabel, homeLabel: UILabel) {
        var homeFont = Fonts.mediumFont
        var awayFont = Fonts.mediumFont
        if awayRuns > 0 {
            awayFont = Fonts.mediumFontBold
        }
        if homeRuns > 0 {
            homeFont = Fonts.mediumFontBold
        }
        configureLabel(label: awayLabel, color: labelTextColor, font: awayFont, data: "\(awayRuns)")
        configureLabel(label: homeLabel, color: labelTextColor, font: homeFont, data: "\(homeRuns)")
    }
    
    private func configureInningsStackView(score: ScoreDisplay) {
        for inning in score.innings {
            let numLabel = UILabel()
            let awayRunsLabel = UILabel()
            let homeRunsLabel = UILabel()
            let currentInningStackView = UIStackView()
            currentInningStackView.axis = .vertical
            currentInningStackView.distribution = .fill
            currentInningStackView.alignment = .center
            currentInningStackView.spacing = 10
            configureLabel(label: numLabel, color: labelTextColor, font: Fonts.mediumFont, data: "\(inning.num ?? 0 )")
            formatRunsLabels(awayRuns: inning.away?.runs ?? 0, homeRuns: inning.home?.runs ?? 0, awayLabel: awayRunsLabel, homeLabel: homeRunsLabel)
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
    }
    
    private func configureTotalRunsStackView(score: ScoreDisplay) {
        totalRunsStackView.addArrangedSubview(runsLabel)
        configureLabel(label: runsLabel, color: labelTextColor, font: Fonts.mediumFont, data: "R")
        totalRunsStackView.addArrangedSubview(awayRunsLabel)
        totalRunsStackView.addArrangedSubview(homeRunsLabel)
        configureLabel(label: awayRunsLabel, color: labelTextColor, font: Fonts.mediumFontBold, data: "\(score.awayTeamRuns)")
        configureLabel(label: homeRunsLabel, color: labelTextColor, font: Fonts.mediumFontBold, data: "\(score.homeTeamRuns)")
    }
    
    private func configureTotalHitsStackView(score: ScoreDisplay) {
        totalHitsStackView.addArrangedSubview(hitsLabel)
        configureLabel(label: hitsLabel, color: labelTextColor, font: Fonts.mediumFont, data: "H")
        totalHitsStackView.addArrangedSubview(awayHitsLabel)
        configureLabel(label: awayHitsLabel, color: labelTextColor, font: Fonts.mediumFont, data: "\(score.awayTeamHits)")
        totalHitsStackView.addArrangedSubview(homeHitsLabel)
        configureLabel(label: homeHitsLabel, color: labelTextColor, font: Fonts.mediumFont, data: "\(score.homeTeamHits)")
    }
    
    private func configureTotalErrorsStackView(score: ScoreDisplay) {
        totalErrorsStackView.addArrangedSubview(errorsLabel)
        configureLabel(label: errorsLabel, color: labelTextColor, font: Fonts.mediumFont, data: "E")
        totalErrorsStackView.addArrangedSubview(awayErrorsLabel)
        configureLabel(label: awayErrorsLabel, color: labelTextColor, font: Fonts.mediumFont, data: "\(score.awayTeamErrors)")
        totalErrorsStackView.addArrangedSubview(homeErrorsLabel)
        configureLabel(label: homeErrorsLabel, color: labelTextColor, font: Fonts.mediumFont, data: "\(score.homeTeamErrors)")
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
        view.spacing = 25
        return view
    }()
    
    let teamsLabel: UILabel = {
        return UILabel()
    }()
    
    let dateLabel: UILabel = {
        return UILabel()
    }()
    
    let boxScoreLabel: UILabel = {
        return UILabel()
    }()
    
    let venueLabel: UILabel = {
        return UILabel()
    }()
    
    let boxScoreContainer: UIView = {
        return UIView()
    }()
    
    let boxScoreStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.alignment = .center
        view.distribution = .equalSpacing
        return view
    }()
    
    let teamStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .equalSpacing
        view.spacing = 10
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
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
    
    let totalRunsStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .center
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
        view.alignment = .center
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
        view.alignment = .center
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
        view.alignment = .center
        view.distribution = .fill
        view.spacing = 10
        return view
    }()
}
