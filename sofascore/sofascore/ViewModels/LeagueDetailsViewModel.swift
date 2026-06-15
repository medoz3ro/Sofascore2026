import Foundation

struct LeagueDetailsViewModel {
    let league: League
    let sport: Sport

    func fetchHeaderViewModel() -> DetailHeaderViewModel {
        var viewModel = DetailHeaderViewModel(
            title: league.name,
            subtitle: league.country?.name ?? "",
            logoUrl: league.logoUrl
        )
        viewModel.flagUrl = CountryFlagOverride.flagUrl(
            for: league.country?.name ?? ""
        )
        return viewModel
    }
}
