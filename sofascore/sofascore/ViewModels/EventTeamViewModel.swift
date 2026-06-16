import UIKit

struct EventTeamViewModel {
    let name: String
    let logo: String?
    let teamId: Int
    let onTapped: (() -> Void)?
}
