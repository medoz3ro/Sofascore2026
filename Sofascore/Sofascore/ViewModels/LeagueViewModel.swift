import UIKit
import SofaAcademic


struct LeagueViewModel {
    let name: String
    let country: String
    let logo: UIImage?
    
    init(league: League, logo: UIImage?) {
        name = league.name
        country = league.country?.name ?? ""
        self.logo = logo
    }
}


