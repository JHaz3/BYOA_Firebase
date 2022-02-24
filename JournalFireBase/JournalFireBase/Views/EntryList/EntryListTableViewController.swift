//
//  EntryListTableViewController.swift
//  JournalFireBase
//
//  Created by Jake Haslam on 2/23/22.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    var viewModal: EntryListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModal = EntryListViewModel(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        print("Add Button Tapped Successfully")
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModal.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        cell.textLabel?.text = viewModal.entries[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToEntry()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let locationToDelete = viewModal.entries[indexPath.row]
            FirebaseController().deleteLocation(locationToDelete)
            viewModal.entries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func goToEntry() {
        let storyboard = UIStoryboard(name: "EntryListDetailViewController", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as?
                EntryDetailViewController else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            let entries = self.viewModal.entries[indexPath.row]
            let detailModel = EntryDetailViewModel(entry: entries, entryListViewModel: self.viewModal)
            vc.viewModel = detailModel
        } else {
            vc.viewModel = EntryDetailViewModel(entryListViewModel: self.viewModal)
        }
    }
}

extension EntryListTableViewController: EntryListTableViewControllerDelegate {
    func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
