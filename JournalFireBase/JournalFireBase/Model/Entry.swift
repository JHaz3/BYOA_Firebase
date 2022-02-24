//
//  Entry.swift
//  JournalFireBase
//
//  Created by Jake Haslam on 2/22/22.
//

import Foundation

class Entry {
    enum Key {
        static let collectionType = "entries"
        static let name     = "name"
        static let date     = "date"
        static let entry    = "entry"
        static let uuid     = "uuid"
    }
    
    var name: String
    let date: Date
    var entry: String
    let uuid: String
    
    var entryData: [String : Any] {
        [Key.name  : self.name,
         Key.entry : self.entry,
         Key.date  : self.date,
         Key.uuid  : self.uuid]
    }
    
    init(name: String, date: Date = Date(), entry: String, uuid: String = UUID().uuidString) {
        self.name   = name
        self.date   = date
        self.entry  = entry
        self.uuid   = uuid
    }
    
    init?(fromDictionary dictionary: [String : Any]) {
        guard let name      = dictionary[Key.name] as? String,
              let dateNum   = dictionary[Key.date] as? Double,
              let entry     = dictionary[Key.entry] as? String,
              let uuid      = dictionary[Key.uuid] as? String
        else { return nil }
        
        self.name = name
        self.date = Date(timeIntervalSince1970: dateNum)
        self.entry = entry
        self.uuid = uuid
    }
}
