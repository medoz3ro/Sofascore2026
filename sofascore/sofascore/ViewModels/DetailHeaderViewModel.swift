struct DetailHeaderViewModel {
    let title: String
    let subtitle: String
    let logoUrl: String?
    var flagUrl: String?
    let isSubtitleHidden: Bool

    init(
        title: String,
        subtitle: String,
        logoUrl: String?,
        flagUrl: String? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.logoUrl = logoUrl
        self.flagUrl = flagUrl
        self.isSubtitleHidden = subtitle.isEmpty
    }
}
