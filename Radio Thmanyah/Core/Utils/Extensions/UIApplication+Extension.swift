//
//  UIApplication+Extension.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 12/8/2025.
//

import UIKit

extension UIApplication {
    var keyWindow: UIWindow? {
        // Get the active foreground scene
        connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
}
