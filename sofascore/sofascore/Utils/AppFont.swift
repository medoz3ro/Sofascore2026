import UIKit

extension UIFont{
    static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: size) ?? .boldSystemFont(ofSize: size)
    }
    
    static func micro(size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Micro", size: size) ?? .systemFont(ofSize: size)
    }
}
