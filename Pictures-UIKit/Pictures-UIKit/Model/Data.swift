//
//  Data.swift
//  Pictures-UIKit
//
//  Created by Juan Capponi on 9/21/20.
//  Copyright © 2020 Juan Capponi. All rights reserved.
//

import Foundation

/// PICTURES JSON PARSE
struct JsonAll: Codable {
    let total_results : Int
    let page : Int
    let per_page : Int
    let photos : [Photos]
    let next_page : String
    }


struct Photos: Codable {
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let photographer: String
    let photographer_url: String
    let photographer_id : Int
    let src : PhotoDetails
    let liked : Bool
   
    }

struct PhotoDetails: Codable {
    let original : String
    let large2x : String
    let large:  String
    let medium: String
    let small : String
    let portrait : String
    let landscape :  String
    let tiny : String
}

/// END PICTURES


/// VIDEOS JSON PARSE
struct JsonVideos : Codable {
    let page : Int
    let per_page: Int
    let total_results : Int
    let url : String
    let videos: [Videos]
}

struct Videos: Codable {
    let full_res: Int!
    let tags : [String]!
    let id : Int
    let width : Int
    let height : Int
    let url: String
    let image : String
    let duration : Int
    let user: User
    let video_files : [VideoFiles]
    let video_pictures : [video_Pictures]
}

struct User: Codable {
    let id : Int
    let name : String
    let url : String
}

struct VideoFiles: Codable {
    let id :Int
    let quality : String
    let file_type : String
    let width : Int!
    let height : Int!
    let link : String
}

struct video_Pictures : Codable {
    let id : Int
    let picture : String
    let nr : Int
}

/// END VIDEOS


