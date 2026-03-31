import UIKit

extension URLSession {
    func downloadImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        guard let (data, _) = try? await data(from: url) else { return nil }
        return UIImage(data: data)
    }
}
