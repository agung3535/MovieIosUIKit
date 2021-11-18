//
//  FavoriteEntity.swift
//  MovieIosDicoding
//
//  Created by Putra on 15/11/21.
//

import Foundation
import RealmSwift


class FavoriteEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var popularity: String = ""
    @objc dynamic var releaseData: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var voteAverage: String = ""
    @objc dynamic var voteCount: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
