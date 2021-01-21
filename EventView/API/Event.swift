//
//  Event.swift
//  EventView
//
//  Created by Ludovico Veniani on 1/20/21.
//

import Foundation
import Alamofire

class EventAPI {
    static func markAttendance(eventID: Int, completion: @escaping(Result<Int, Error>) -> ()) {
        let paramaters: [String: Any] = [:]
        
        DispatchQueue.global(qos: .userInitiated).async {
            AF.request("\(domain)/events/\(eventID)", method: .post, parameters: paramaters, encoding: JSONEncoding.default)
                .response { (response) in
                    if response.error == nil {
                        completion(.success(response.response!.statusCode))
                        
                    } else {
                        completion(.failure(response.error!))
                    }
                    
            }
        }
    }
    
    
    
    
    static func getEvents(completion: @escaping(Result<[Event], Error>) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            AF.request("\(domain)/events", method: .get, encoding: JSONEncoding.default)
                .responseJSON { (response) in
                    
                    if response.error == nil {
                        do {
                            let events = try JSONDecoder().decode([Event].self, from: response.data!)
                            
                            completion(.success(events))
                        } catch let error {
                            completion(.failure(error))
                        }
                    } else {
                        completion(.failure(response.error!))
                    }
                    
            }
        }
    }
    
    static func getEventDetails(eventID: Int, completion: @escaping(Result<Event, Error>) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            AF.request("\(domain)/events/\(eventID)", method: .get, encoding: JSONEncoding.default)
                .responseJSON { (response) in
                    
                    if response.error == nil {
                        do {
                            let event = try JSONDecoder().decode(Event.self, from: response.data!)
                            
                            completion(.success(event))
                        } catch let error {
                            completion(.failure(error))
                        }
                    } else {
                        completion(.failure(response.error!))
                    }
                    
            }
        }
    }
}
