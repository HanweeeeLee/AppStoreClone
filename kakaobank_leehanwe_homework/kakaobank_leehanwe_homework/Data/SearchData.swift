//
//  SearchData.swift
//  kakaobank_leehanwe_homework
//
//  Created by hanwe on 2021/03/20.
//

import FlexibleModelProtocol

struct SearchData: FlexibleModelProtocol {
    var screenshotUrls: [String] = []
    var ipadScreenshotUrls: [String] = []
    var icon60: String = ""
    var icon512: String = ""
    var icon100: String = ""
    var minimumOsVersion: String = ""
    var trackName: String = ""
    var trackCensoredName: String? = ""
    var releaseDate: String = ""
    var sellerName: String = ""
    var primaryGenreName: String = ""
    var languageCodesISO2A: [String] = []
    var fileSizeBytes: String = ""
    var sellerUrl: String? = ""
    var price: String = ""
    var contentAdvisoryRating: String = ""
    var averageUserRating: Float = 0.0
    var trackId: Int = -1
    var currentVersionReleaseDate: String = ""
    var releaseNotes: String = ""
    var description: String = ""
    var version: String = ""
    var userRatingCount: Int = -1
    var trackViewUrl: String? = ""
    var supportedDevices: [String]? = []
    
    enum CodingKeys : String, CodingKey {
        case screenshotUrls
        case ipadScreenshotUrls
        case icon60 = "artworkUrl60"
        case icon512 = "artworkUrl512"
        case icon100 = "artworkUrl100"
        case minimumOsVersion
        case trackName
        case trackCensoredName
        case releaseDate
        case sellerName
        case primaryGenreName
        case languageCodesISO2A
        case fileSizeBytes
        case sellerUrl
        case price = "formattedPrice"
        case contentAdvisoryRating
        case averageUserRating
        case trackId
        case currentVersionReleaseDate
        case releaseNotes
        case description
        case version
        case userRatingCount
        case trackViewUrl
        case supportedDevices
    }
}
