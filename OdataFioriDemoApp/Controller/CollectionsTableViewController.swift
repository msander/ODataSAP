//
//  CollectionsTableViewController.swift
//  OdataFioriDemoApp
//
//  Created by Riya Ganguly on 09/06/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import UIKit
import SAPFiori

class CollectionsTableViewController: UITableViewController , Notifier{

    var collections = [String]()
    var filteredCollections = [String]()
    var searchController: FUISearchController?
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var dataAccess : ESPMContainerDataAccess!
    weak var delegate: MasterDetailCustomerDelegate?
    
    @IBOutlet weak var syncButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collections"
        self.addtableHeaderView();
        syncButton .setBackgroundImage(UIImage(named: "index.png"), for: .normal, style: .plain, barMetrics: .compact)
        self.dataAccess = appDelegate.espmContainer
        self.collections = CollectionType.allValues.map({ (collectionType) -> String in
            return collectionType.rawValue
        })
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        //performSegue(withIdentifier: "ShowDetail", sender: self)

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if appDelegate.isLoginSuccessful {
            self.delegate?.showDetail(type: CollectionType(rawValue: collections[0])!)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func uploadData(_ sender: UIBarButtonItem) {
        self.dataAccess.uploadOfflineStore{ (error) in
            guard error.characters.count > 0 else {
                DispatchQueue.main.async {
                    self.displayAlert(
                        title: "Message",
                        message: "Sync Successful!!",
                        buttonText:"OK")
                }
                return
            }
            self.displayAlert(
                title: "Message",
                message: error,
                buttonText:"OK")
        }
    }

    // MARK: - Class Methods
    
    func addtableHeaderView(){
        searchController = FUISearchController(searchResultsController: nil)
        searchController!.searchResultsUpdater = self// as? UISearchResultsUpdating
        searchController!.dimsBackgroundDuringPresentation = false
        searchController!.hidesNavigationBarDuringPresentation = false
        searchController!.searchBar.placeholderText = "Search The List"
        self.tableView.tableHeaderView = searchController?.searchBar
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredCollections = collections.filter{ collectiondata in collectiondata.lowercased().contains(searchText.lowercased())}
        print(filteredCollections)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if ((searchController?.isActive)! && searchController?.searchBar.text != "") {
            return filteredCollections.count
        }
        return collections.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FUISimplePropertyFormCell.reuseIdentifier, for: indexPath) as! FUISimplePropertyFormCell
        if ((searchController?.isActive)! && searchController?.searchBar.text != "") {
            cell.keyName = self.filteredCollections[indexPath.row]
        }else{
            cell.keyName = self.collections[indexPath.row]
        }
        cell.valueTextField.isHidden = false
        cell.valueTextField.backgroundColor =  UIColor.blue
        cell.valueTextField.layer.cornerRadius = 12
        cell.valueTextField.text = "20"
        cell.valueTextField.textAlignment = .center
        cell.valueTextField.textColor = UIColor.white
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                
                var selectedCollection:CollectionType
                if ((searchController?.isActive)! && searchController?.searchBar.text != "") {
                    selectedCollection = CollectionType(rawValue: filteredCollections[indexPath.row])!
                }else{
                    selectedCollection = CollectionType(rawValue: collections[indexPath.row])!
                }
                let controller = (segue.destination as! UINavigationController).topViewController as! MasterTableViewController
                controller.collectionType = selectedCollection
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
}
extension CollectionsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}
