//
//  APIError.swift
//  GetUntukBella
//
//  Created by Putra on 09/11/21.
//

import Foundation

enum APIError: LocalizedError {
    case errorDecoding
    case invalidURL
    case unknownError
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
            
        case .errorDecoding:
            return "Response could not be decoded"
        case .invalidURL:
            return "INVALID URL"
        case .unknownError:
            return "Something went wrong !"
        case .serverError(let error):
            return error
        }
    }
}
