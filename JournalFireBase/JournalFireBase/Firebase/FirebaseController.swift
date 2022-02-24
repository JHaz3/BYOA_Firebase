//
//  FirebaseController.swift
//  JournalFireBase
//
//  Created by Jake Haslam on 2/23/22.
//

import Foundation
import Firebase

enum FirebaseError: LocalizedError {
    case failure(Error)
    case noData
    case failedToDecode
    
    var description: String {
        switch self {
        case .failure(let error):
            return ":❌: \(error.localizedDescription) -> \(error)"
        case .noData:
            return ":❌: No data found!"
        case .failedToDecode:
            return ":❌: Unable to decode data"
        }
    }
}

struct FirebaseController {
    let ref = Database.database().reference()
    
    func saveLocation(_ entry: Entry) {
        ref.child(Entry.Key.collectionType).child(entry.uuid).setValue(entry.entryData)
    }
    
    func deleteLocation(_ entry: Entry) {
        ref.child(Entry.Key.collectionType).child(entry.uuid).setValue(nil)
    }
    
    func getEntries(completion: @escaping (Result<[Entry], FirebaseError>)-> Void) {
        ref.child(Entry.Key.collectionType).getData { error, snapshot in
            if let error = error {
                completion(.failure(.failure(error)))
                return
            }
            
            guard let data = snapshot.value as? [String : [String : Any]] else {
                completion(.failure(.noData)); return }
            let dataArray = Array(data.values)
            let locations = dataArray.compactMap({ Entry(fromDictionary: $0) })
            let sortedLocations = locations.sorted(by: { $0.date > $1.date })
            completion(.success(sortedLocations))
        }
    }
