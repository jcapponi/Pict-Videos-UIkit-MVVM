//
//  Constants.swift
//  Pictures-UIKit
//
//  Created by Juan Capponi on 9/21/20.
//  Copyright © 2020 Juan Capponi. All rights reserved.
//

import Foundation


struct Constants {
    static let urlPictures = "https://api.pexels.com/v1/search?query=nature&per_page=20"
    static let urlVideos = "https://api.pexels.com/videos/search?query=nature&per_page=40&page=1"
    static let headers = [
        "Authorization": "563492ad6f91700001000001a1c88b38c8244e2299250588ae8f9c44"
    ]
    static let customViewCellHeigth = 110
}
