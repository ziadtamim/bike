//
//  Service.swift
//  CobiBike
//
//  Created by Ziad on 10/29/18.
//  Copyright © 2018 ByZiad. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

extension Data {
    
    func cast<T>() throws -> T {
        guard let topLevel = try JSONSerialization.jsonObject(with: self, options: .allowFragments) as? T else {
            throw HTTPError.invalidValue("Top-level did not encode any values.")
        }
        return topLevel
    }
}

protocol BikeServiceContract {
    func get(location: Location, completion: @escaping (Result<[Bike]>) -> Void)
    func rent(id: String, completion: @escaping(Result<Bike>) -> Void)
    func `return`(id: String, completion: @escaping(Result<Bike>) -> Void)
    func new(bike: Bike, completion: @escaping (Result<Bike>) -> Void)
}

class BikeService: BikeServiceContract {
    private let baseURL: URL
    private let httpClient: HTTPClientContract
    private let jsonDecoder: JSONDecoder
    private let jsonEncoder: JSONEncoder
    
    init(httpClient: HTTPClientContract = HTTPClient(), baseURL: URL = URL(string: Config.baseURL)!) {
        self.httpClient = httpClient
        self.baseURL = baseURL
        self.jsonDecoder = JSONDecoder()
        self.jsonEncoder = JSONEncoder()
    }
    
    func get(location: Location, completion: @escaping (Result<[Bike]>) -> Void) {
        let params = try? self.jsonEncoder.encode(location).cast() as [String: Any]
        let url = URL(string: "bikes", relativeTo: baseURL)!
        let request = HTTPRequest(url: url, params: params)
        httpClient.send(request: request) { result in
            switch result {
            case let .success(value):
                completion(Result(value: { try self.jsonDecoder.decode([Bike].self, from: value)}))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func new(bike: Bike, completion: @escaping (Result<Bike>) -> Void) {
        let params = try? self.jsonEncoder.encode(bike).cast() as [String: Any]
        let url = URL(string: "bikes", relativeTo: baseURL)!
        let request = HTTPRequest(url: url, method: .post, params: params)
        httpClient.send(request: request) { result in
            switch result {
            case let .success(value):
                completion(Result(value: { try self.jsonDecoder.decode(Bike.self, from: value)}))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func rent(id: String, completion: @escaping(Result<Bike>) -> Void) {
        let url = URL(string: "bikes/\(id)/rented", relativeTo: baseURL)!
        let request = HTTPRequest(url: url, method: .put)
        httpClient.send(request: request) { result in
            switch result {
            case let .success(value):
                completion(Result(value: { try self.jsonDecoder.decode(Bike.self, from: value)}))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func `return`(id: String, completion: @escaping(Result<Bike>) -> Void) {
        let url = URL(string: "bikes/\(id)/rented", relativeTo: baseURL)!
        let request = HTTPRequest(url: url, method: .delete)
        httpClient.send(request: request) { result in
            switch result {
            case let .success(value):
                completion(Result(value: { try self.jsonDecoder.decode(Bike.self, from: value)}))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
}
