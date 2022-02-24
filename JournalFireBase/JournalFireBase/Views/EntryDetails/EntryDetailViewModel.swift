//
//  EntryDetailViewModel.swift
//  JournalFireBase
//
//  Created by Jake Haslam on 2/23/22.
//

import Foundation

class EntryDetailViewModel {
    
    var entry: Entry?
    private let entryListViewModel: EntryListViewModel
    
    init(entry: Entry? = nil, entryListViewModel: EntryListViewModel) {
        self.entry      = entry
        self.entryListViewModel  = entryListViewModel
    }
    
    func saveEntry(withName name: String, entryDetails: String) {
        if let entry = entry {
            entry.name      = name
            entry.entry     = entryDetails
        } else {
            entry = Entry(name: name, entry: entryDetails)
            entryListViewModel.entries.append(self.entry!)
        }
        FirebaseController().saveLocation(self.entry!)
    }
}
