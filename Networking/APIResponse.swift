//
//  APIResponse.swift
//  GetUntukBella
//
//  Created by Putra on 09/11/21.
//

import Foundation

struct APIResponse<T: Codable>: Codable {
    let status: Int?
    let error: Bool?
    let message: String?
    let data : T?
    
    enum CodingKeys: String, CodingKey {
            case status,error,message
            case data = "restaurants"
        }
}
