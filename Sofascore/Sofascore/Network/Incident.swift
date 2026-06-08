import Foundation

struct GoalIncident: Decodable {
    let minute: Int
    let extraMinute: Int?
    let isHomeTeam: Bool
    let player: String?
    let score: String?
    let scoreDiff: Int?
}

struct CardIncident: Decodable {
    let minute: Int
    let extraMinute: Int?
    let isHomeTeam: Bool
    let player: String?
    let type: String
}

struct FoulIncident: Decodable {
    let minute: Int
    let extraMinute: Int?
    let isHomeTeam: Bool
    let player: String?
}

enum Incident: Decodable {
    case goal(GoalIncident)
    case yellowCard(CardIncident)
    case redCard(CardIncident)
    case foul(FoulIncident)
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)

        switch type {
        case "GOAL":
            self = .goal(try GoalIncident(from: decoder))
        case "YELLOW_CARD":
            self = .yellowCard(try CardIncident(from: decoder))
        case "RED_CARD":
            self = .redCard(try CardIncident(from: decoder))
        case "FOUL":
            self = .foul(try FoulIncident(from: decoder))
        default:
            self = .unknown
        }
    }

    private enum CodingKeys: String, CodingKey {
        case type
    }
}
