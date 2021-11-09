//
//  Route.swift
//  GetUntukBella
//
//  Created by Putra on 09/11/21.
//

import Foundation


enum Route {
    static let baseUrl = "https://restaurant-api.dicoding.dev"
    
    case getResto
    
    var desc: String {
        switch self {
        case .getResto:
            return "/list"
        }
    }
}
