import UIKit

enum IncidentMinuteFormatter {
    static func format(_ minute: Int, extra: Int?) -> String {
        if let extra = extra {
            return "\(minute)+\(extra)'"
        }
        return "\(minute)'"
    }
}

struct IncidentViewModel {
    let minute: String
    let playerName: String
    let description: String
    let icon: UIImage?
    let isHomeTeam: Bool
    let score: String?
    let isGoal: Bool
    let isBasketball: Bool

    init(incident: Incident, sport: Sport) {
        isBasketball = sport == .basketball

        switch incident {
        case .goal(let goal):
            minute = IncidentMinuteFormatter.format(
                goal.minute,
                extra: goal.extraMinute
            )
            playerName = goal.player ?? ""
            description = ""
            isHomeTeam = goal.isHomeTeam
            score = goal.score
            isGoal = true

            if sport == .basketball {
                switch goal.scoreDiff {
                case 1: icon = UIImage(named: "basketball_num_1")
                case 2: icon = UIImage(named: "basketball_num_2")
                case 3: icon = UIImage(named: "basketball_num_3")
                default: icon = UIImage(named: "basketball_num_2")
                }
            } else {
                icon = UIImage(named: "goal_icon")
            }

        case .yellowCard(let card):
            minute = IncidentMinuteFormatter.format(
                card.minute,
                extra: card.extraMinute
            )
            playerName = card.player ?? ""
            description = .yellowCard
            icon = UIImage(named: "yellow_card_icon")
            isHomeTeam = card.isHomeTeam
            score = nil
            isGoal = false

        case .redCard(let card):
            minute = IncidentMinuteFormatter.format(
                card.minute,
                extra: card.extraMinute
            )
            playerName = card.player ?? ""
            description = .redCard
            icon = UIImage(named: "red_card_icon")
            isHomeTeam = card.isHomeTeam
            score = nil
            isGoal = false

        case .foul(let foul):
            minute = IncidentMinuteFormatter.format(
                foul.minute,
                extra: foul.extraMinute
            )
            playerName = foul.player ?? ""
            description = .foul
            icon = UIImage(named: "goal_icon")
            isHomeTeam = foul.isHomeTeam
            score = nil
            isGoal = false

        case .unknown:
            minute = ""
            playerName = ""
            description = ""
            icon = nil
            isHomeTeam = true
            score = nil
            isGoal = false
        }
    }
}
