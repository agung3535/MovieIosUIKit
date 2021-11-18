//
//  StringExtension.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
