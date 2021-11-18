//
//  UIImageView.swift
//  MovieIosDicoding
//
//  Created by Putra on 17/11/21.
//

import Foundation
import UIKit

extension UIImageView {

    func makeRounded() {
//        let radius = bounds.height / 2
//        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
//        self.layer.cornerRadius = radius
      
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.width / 2
    }
}
