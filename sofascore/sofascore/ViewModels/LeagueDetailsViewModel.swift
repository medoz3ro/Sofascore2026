import Foundation

struct LeagueDetailsViewModel {
    let league: League
    let sport: Sport

    func fetchHeaderViewModel() async -> LeagueHeaderDetailViewModel {
        var viewModel = LeagueHeaderDetailViewModel(league: league)
        do {
            viewModel.flagUrl = try await APIClient.fetchCountryFlag(
                countryName: league.country?.name ?? ""
            )
        } catch {
            print("Error fetching flag: \(error)")
        }
        return viewModel
    }
}
