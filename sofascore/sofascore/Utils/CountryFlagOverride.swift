import Foundation

enum CountryFlagOverride {
    static func flagUrl(for countryName: String) -> String? {
        let overrides: [String: String] = [
            "England": "https://flagcdn.com/w40/gb-eng.png",
        ]
        return overrides[countryName]
    }
}
