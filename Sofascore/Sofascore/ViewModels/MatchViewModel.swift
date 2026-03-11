//
//  MatchViewModel.swift
//  Sofascore
//
//  Created by Benjamin on 11.03.2026..
//

import SnapKit
import SofaAcademic
import UIKit


struct MatchViewModel {
    let homeTeamName: String
    let awayTeamName: String
    let homeTeamNameColor: UIColor
    let awayTeamNameColor: UIColor
    let homeTeamLogoUrl: String?
    let awayTeamLogoUrl: String?
    let homeScore: String?
    let awayScore: String?
    let homeScoreColor: UIColor
    let awayScoreColor: UIColor
    let time: String
    let status: String
    let scoreColor: UIColor
    let startTimeColor: UIColor
    let statusColor: UIColor
    
    init(event: Event) {
        homeTeamName = event.homeTeam.name
        awayTeamName = event.awayTeam.name
        homeTeamLogoUrl = event.homeTeam.logoUrl
        awayTeamLogoUrl = event.awayTeam.logoUrl
        homeScore = event.homeScore.map { "\($0)" }
        awayScore = event.awayScore.map { "\($0)" }
        
        if event.status == .inProgress {
            homeTeamNameColor = .black
            awayTeamNameColor = .black
            homeScoreColor = AppColors.liveRed
            awayScoreColor = AppColors.liveRed
        }else if event.status == .finished {
            if (event.homeScore ?? 0) < (event.awayScore ?? 0) {
                homeTeamNameColor = AppColors.grayText
                awayTeamNameColor = .black
                homeScoreColor = AppColors.grayText
                awayScoreColor = .black
            } else if (event.homeScore ?? 0) > (event.awayScore ?? 0) {
                homeTeamNameColor = .black
                awayTeamNameColor = AppColors.grayText
                homeScoreColor = .black
                awayScoreColor = AppColors.grayText
            } else {
                homeTeamNameColor = .black
                awayTeamNameColor = .black
                homeScoreColor = .black
                awayScoreColor = .black
            }
        } else {
            homeTeamNameColor = .black
            awayTeamNameColor = .black
            homeScoreColor = .black
            awayScoreColor = .black
        }
        
        let date = Date(timeIntervalSince1970: TimeInterval(event.startTimestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = AppStrings.Match.timeFormat
        time = formatter.string(from: date)
        
        switch event.status {
        case .notStarted: status = AppStrings.Match.notStarted
        case .inProgress:
            let elapsed = Int((Date().timeIntervalSince1970 - Double(event.startTimestamp)) / 60)
            status = "\(elapsed)'"
        case .halftime: status = AppStrings.Match.halftime
        case .finished: status = AppStrings.Match.finished
        }
        
        switch event.status {
        case .inProgress:
            scoreColor = AppColors.liveRed
            statusColor = AppColors.liveRed
            startTimeColor = AppColors.liveRed
        case .finished:
            scoreColor = .gray
            statusColor = .gray
            startTimeColor = .gray
        default:
            scoreColor = .gray
            statusColor = .gray
            startTimeColor = .gray
        }
    }
}


