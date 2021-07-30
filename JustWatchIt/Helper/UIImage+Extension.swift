//
//  UIImage+Extension.swift
//  JustWatchIt
//
//  Created by Lawrence Dizon on 7/29/21.
//

import UIKit

extension UIImage {
    var jpeg: Data? { jpegData(compressionQuality: 1) }  // QUALITY min = 0 / max = 1
}
