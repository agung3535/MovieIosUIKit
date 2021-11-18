//
//  UIViewExtension.swift
//  MovieIosDicoding
//
//  Created by Putra on 16/11/21.
//

import Foundation
import UIKit
extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
