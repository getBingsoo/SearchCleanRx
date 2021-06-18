//
//  Search.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/18.
//

import Foundation

struct SearchResult: Codable {
    let resultCount: Int?
    let results: [Item]?
}

struct Item: Codable {
    let primaryGenreName: String?
    let artworkUrl100: String?
    let sellerUrl: String?
    let currency: String?
    let artworkUrl512: String?
    let ipadScreenshotUrls: [String]?
    let fileSizeBytes: String?
    let genres: [String]?
    let languageCodesISO2A: [String]?
    let artworkUrl60: String?
    let supportedDevices: [String]?
    let trackViewUrl: String?
    let description: String?
    let bundleId: String?
    let version: String?
    let artistViewUrl: String?
    let userRatingCountForCurrentVersion: Int?
    let appletvScreenshotUrls: [String]?
    let isGameCenterEnabled: Bool?
    let releaseDate: String?
    let wrapperType: String?
    let minimumOsVersion: String?
    let formattedPrice: String?
    let primaryGenreId: Int?
    let currentVersionReleaseDate: String?
    let userRatingCount: Int?
    let artistId: Int?
    let artistName: String?
    let price: Int?
    let trackCensoredName: String?
    let trackName: String?
    let features: [String]?
    let kind: String?
    let screenshotUrls: [String]?
    let releaseNotes: String?
    let sellerName: String?
    let averageUserRating: Double?
    let contentAdvisoryRating: String?
}
