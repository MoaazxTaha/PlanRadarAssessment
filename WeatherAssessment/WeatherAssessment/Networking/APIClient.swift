//
//  APIManagerWrapper.swift
//  TryCitiesListView
//
//  Created by Moaaz Ahmed Fawzy Taha on 15/06/2024.
//

import Foundation
import Combine

class APIClient {
    static let shared = APIClient()
    private let apiEndPoints = APIEndPoints.sharedInstance()
    
    private init() {}
    
    func requestWithAPI<T: Decodable>(_ api: API, parameters: [String: Any]) -> AnyPublisher<T, Error> {
        let subject = PassthroughSubject<T, Error>()
        
        let disposable = apiEndPoints?.request(with: api, parameters: parameters)?.subscribeNext({ jsonObject in
            if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: []),
               let decodedObject = try? JSONDecoder().decode(T.self, from: data) {
                subject.send(decodedObject)
            } else {
                subject.send(completion: .failure(NetworkError(code: 0)))
            }
            subject.send(completion: .finished)
        }, error: { error in
            if let error {
                subject.send(completion: .failure(error))
            } else {
                subject.send(completion: .failure(NetworkError(code: 0)))
            }
        })
        
        return subject
            .handleEvents(receiveCancel: {
                disposable?.dispose()
            })
            .eraseToAnyPublisher()
    }
    
    func requestWithURL<T: Decodable>(_ url: URL, method: HTTPMethod) -> AnyPublisher<T, Error> {
        let subject = PassthroughSubject<T, Error>()
        
        let disposable = apiEndPoints?.request(with: url, method: method)?.subscribeNext({ jsonObject in
            if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: []),
               let decodedObject = try? JSONDecoder().decode(T.self, from: data) {
                subject.send(decodedObject)
            } else {
                subject.send(completion: .failure(NetworkError(code: 0)))
            }
            subject.send(completion: .finished)
        }, error: { error in
            if let error {
                subject.send(completion: .failure(error))
            } else {
                subject.send(completion: .failure(NetworkError(code: 0)))
            }
        })
        
        return subject
            .handleEvents(receiveCancel: {
                disposable?.dispose()
            })
            .eraseToAnyPublisher()
    }
}
