//
//  UIImageView+DownloadImage.swift
//  InStatTest
//
//  Created by andy on 01.07.2022.
//

import UIKit

extension UIImageView {
    func loadImage(at url: URL) {
        UIImageLoader.loader.load(url, for: self)
    }

    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}
