import Foundation

struct CountryInfo: Decodable {
    struct Flags: Decodable {
        let png: String
    }
    let flags: Flags
}
