//
//  APIService.swift
//  GetUntukBella
//
//  Created by Putra on 09/11/21.
//

import Foundation


struct APIService {
    
    static let shared = APIService()
    
    private init(){}
    
    func getListResto(completion: @escaping(Result<[Resto], Error>)-> Void) {
        request(route: .getResto, method: .get, completion: completion)
    }
    
    private func handleResponse<T:Codable>(result: Result<Data, Error>?, completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            print("unknown error")
            completion(.failure(APIError.unknownError))
            return
        }
        
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let dataFromJson = try? decoder.decode(APIResponse<T>.self, from: data) else {
                print("Error is : \(APIError.errorDecoding)")
                completion(.failure(APIError.errorDecoding))
                return
            }
            let error = true
            if error == dataFromJson.error {
                print("Error is cek from json : \(APIError.serverError(dataFromJson.message!))")
                completion(.failure(APIError.serverError(dataFromJson.message!)))
                return
            }
            if let decodeData = dataFromJson.data {
                completion(.success(decodeData))
            }else {
                print("data is : \(dataFromJson.data)")
                completion(.failure(APIError.errorDecoding))
            }
        case .failure(let error):
            print("Error is :\(error)")
            completion(.failure(error))
        }
    }
    
    private func createRequest(route: Route, method: Method, parameter: [String: Any]? = nil) -> URLRequest? {
        let urlString = Route.baseUrl + route.desc
        guard let url = URL(string: urlString) else { return nil }
        var urlReq = URLRequest(url: url)
        urlReq.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlReq.httpMethod = method.rawValue
        
        if let params = parameter {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map {
                    URLQueryItem(name: $0, value: "\($1)")
                }
                urlReq.url = urlComponent?.url
            case .post,.delete,.patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: parameter, options: [])
                urlReq.httpBody = bodyData
            }
            
        }
        return urlReq
    }
    
    //blue print request bel
    private func request<T: Codable>(route: Route,
                                     method: Method,
                                     parameter: [String: Any]? = nil,
                                     completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = createRequest(route: route, method: method, parameter: parameter) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            var result: Result<Data, Error>?
            if let resData = data {
                result = .success(resData)
                let responseString = String(data: resData, encoding: .utf8) ?? "Could not strignify our data"
            }else if let resError = error {
                result = .failure(resError)
                print("The error is: \(resError.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
        //jangan smpai lupa di resume bel
    }
}
