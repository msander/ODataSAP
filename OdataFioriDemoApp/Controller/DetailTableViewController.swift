//
//  DetailTableViewController.swift
//  OdataFioriDemoApp
//
//  Created by Riya Ganguly on 09/06/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import UIKit
import SAPOData
import SAPFiori

class DetailTableViewController: UITableViewController , Notifier {

    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var selectedEntity: EntityValue!
    var cellView: Any!
    private var dataAccess : ESPMContainerDataAccess!
    
    var collectionType: CollectionType = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataAccess = appDelegate.espmContainer
        title = collectionType.rawValue
        tableView.register(FUISimplePropertyFormCell.self, forCellReuseIdentifier: "FUICell")
        self.generateDetailViewClassObject()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Class Methods
    func generateDetailViewClassObject(){
        switch self.collectionType {
        case .customers:
            if(self.selectedEntity == nil){
                self.selectedEntity = Customer()
            }
            let currentEntity = self.selectedEntity as? Customer
            cellView = CustomerDetailView(dataAccess: self.dataAccess , selectedEntity : currentEntity!)
        default:
            break

        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cellView as! CustomerDetailView).getEntityCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FUICell", for: indexPath) as! FUISimplePropertyFormCell
        switch self.collectionType {
        case .customers:
            (cellView as! CustomerDetailView).prepareCellForCustomerEntity(tableview: tableView, indexPath: indexPath,cell: cell)
        default:
            break
        }
        return cell
    }
    
    // MARK: - Event Handler
    func createSelectedEntity(){
        self.displayAlert(title: "mes", message: "createSelectedEntity", buttonText: "Ok")
    }
    func cancel(){
        //        self.displayAlert(title: "mes", message: "cancel", buttonText: "Ok")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func updateEntity(_ sender: AnyObject) {
        DispatchQueue.global().async {
            do {
                try self.dataAccess.offlineService.updateEntity(self.selectedEntity)
                DispatchQueue.main.async {
                    self.displayAlert(title: "Update entry finished", message: "The operation was successful", buttonText: "OK")
                }
            }catch{
                self.displayAlert(title: "Update entry failed", message: "The operation was not successful", buttonText: "OK")
            }
        }
    }
}
