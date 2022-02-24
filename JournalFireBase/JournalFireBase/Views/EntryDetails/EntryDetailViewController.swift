//
//  EntryDetailViewController.swift
//  JournalFireBase
//
//  Created by Jake Haslam on 2/23/22.
//

import UIKit

class EntryDetailViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    
    // MARK: - Properties
    var viewModel: EntryDetailViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        updateUI()
    }
    
    // MARK: - IBActions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
              !name.isEmpty,
              let details = detailsTextView.text
        else { return }
        viewModel.saveEntry(withName: name, entryDetails: details)
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Functions
    private func updateUI() {
        if let entry = viewModel.entry {
            self.nameTextField.text = entry.name
            self.detailsTextView.text = entry.entry
        }
    }
}
