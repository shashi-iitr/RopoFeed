//
//  Feed.swift
//  RopoFeed
//
//  Created by shashi kumar on 14/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import Foundation
import ObjectMapper

class Feed: Mappable {
    var id: String?
    var username: String?
    var about: String?
    var followers: Int?
    var following: Int?
    var imageURL: String?
    var profileURL: String?
    var handle: String?
    var isFollowing: Bool?
    var createdOn: Int?
    var verb: String?
    var desc: String?
    var userId: String?
    var url: String?
    var type: String?
    var title: String?
    var likeFlag: Bool?
    var likesCount: Int?
    var commenCount: Int?
    var si: String?
    
    
    required init?(_ map: Map) { }
    
    func mapping(map: Map) {
        id          <- map["id"]
        about       <- map["about"]
        username    <- map["username"]
        followers   <- map["followers"]
        following   <- map["following"]
        imageURL    <- map["image"]
        profileURL  <- map["url"]
        handle      <- map["handle"]
        isFollowing <- map["is_following"]
        createdOn   <- map["createdOn"]
        verb        <- map["verb"]
        desc        <- map["description"]
        userId      <- map["db"]
        url         <- map["url"]
        type        <- map["type"]
        title       <- map["title"]
        likeFlag    <- map["like_flag"]
        likesCount  <- map["likes_count"]
        commenCount <- map["comment_count"]
        si          <- map["si"]
        
    }
}
