//
//  EntryListViewModel.swift
//  JournalFireBase
//
//  Created by Jake Haslam on 2/23/22.
//

import Foundation

protocol EntryListTableViewControllerDelegate: EntryListTableViewController {
    func updateTableView()
}

class EntryListViewModel {
    var entries = [Entry]()
    private weak var delegate: EntryListTableViewControllerDelegate?
    
    init(delegate: EntryListTableViewControllerDelegate) {
        self.delegate = delegate
        self.fetchEntries()
    }
    
    private func fetchEntries() {
        FirebaseController().getEntries { result in
            switch result {
            case .success(let entries):
                self.entries = entries
                self.delegate?.updateTableView()
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---/n \(error)")
            }
        }
    }
}
