import UIKit

extension String {

    // MARK: - Match Status
    static let notStarted = "-"
    static let halftime = "HT"
    static let finished = "FT"
    static let fullTime = "Full Time"

    // MARK: - Sports
    static let football = "Football"
    static let basketball = "Basketball"
    static let americanFootball = "Am. Football"
    static let seperator = "-"

    // MARK: - Settings
    static let language = NSLocalizedString("language", comment: "")
    static let english = "English"
    static let croatian = "Hrvatski"
    static let settings = NSLocalizedString("settings", comment: "")
    static let theme = NSLocalizedString("theme", comment: "")
    static let light = NSLocalizedString("light", comment: "")
    static let dark = NSLocalizedString("dark", comment: "")
    static let eventsRowCount = "Events"
    static let leaguesRowCount = "Leagues"
    static let databaseTitle = "Database"
    static let languageChangedTitle = "Language Changed"
    static let languageChangedMessage = "Please restart the app to apply the language change."

    // MARK: - Auth
    static let login = "Login"
    static let loginButton = "Log In"
    static let usernamePlaceholder = "Username"
    static let passwordPlaceholder = "Password"
    static let logout = NSLocalizedString("logout", comment: "")
    static let account = NSLocalizedString("account", comment: "")
    static let loginError = "Login failed. Check your credentials."
    static let emptyFieldsError = "Please enter username and password."

    // MARK: - Incidents
    static let yellowCard = "Yellow Card"
    static let redCard = "Red Card"
    static let foul = "Foul"

    // MARK: - League Details
    static let matches = NSLocalizedString("matches", comment: "")
    static let standings = NSLocalizedString("standings", comment: "")
    static let round = NSLocalizedString("round", comment: "")
    static let standingsPosition = "#"
    static let standingsTeam = "Team"
    static let tournaments = NSLocalizedString("tournaments", comment: "")

    // MARK: - Team Details
    static let details = NSLocalizedString("details", comment: "")
    static let players = NSLocalizedString("players", comment: "")
    static let teamInfo = NSLocalizedString("teamInfo", comment: "")
    static let totalPlayers = NSLocalizedString("totalPlayers", comment: "")
    static let foreignPlayers = NSLocalizedString("foreignPlayers", comment: "")
    static let venue = NSLocalizedString("venue", comment: "")
    static let stadium = NSLocalizedString("stadium", comment: "")

    // MARK: - Player Details
    static let nationality = NSLocalizedString("nationality", comment: "")
    static let position = NSLocalizedString("position", comment: "")
    static let jersey = NSLocalizedString("jersey", comment: "")
    
    // MARK: - About
    static let about = "About"
    static let aboutClass = "Class 2026"
    static let aboutAppName = "App Name"
    static let aboutAppNameValue = "Mini Sofascore App"
    static let aboutApiCredit = "API Credit"
    static let aboutApiCreditValue = "Sofascore"
    static let aboutDeveloper = "Developer"
    static let aboutDeveloperValue = "Benjamin Sabo"
}
