//
//  SearchResult.swift
//  StoreSearch
//
//  Created by Maryna Bolotska on 06/11/23.
//

import Foundation


class ResultArray: Codable {
    var resultCount = 0
    var results = [SearchResult]()
    
    
}
class SearchResult: Codable, CustomStringConvertible  {
    var description: String = ""
    
   var trackPrice: Double? = 0.0
    var currency = ""
    var imageSmall = ""
    var imageLarge = ""
    var storeURL: String? = ""
    var genre = ""
    
    
    enum CodingKeys: String, CodingKey {
        case imageSmall = "artworkUrl60"
        case imageLarge = "artworkUrl100"
        case storeURL = "trackViewUrl"
        case genre = "primaryGenreName"
        case kind, artistName, trackName
        case trackPrice, currency
    }
    
  var artistName: String? = ""
  var trackName: String? = ""
    var kind: String? = ""
    
    
    
  var name: String {
    return trackName ?? ""
  }
    
//    var description: String {
//        return "\nResult - Kind: \(kind ?? "None"), Name: \(name),
//        Artist Name: \(artistName ?? "None")"
//    }
}
