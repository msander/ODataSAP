//
//  CustomerDetailView.swift
//  OdataFioriDemoApp
//
//  Created by Riya Ganguly on 12/06/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import Foundation
import UIKit
import SAPOData
import SAPCommon
import SAPFiori


class CustomerDetailView: NSObject{
    
    let dataAccess: ESPMContainerDataAccess!
    var selectedEntity: Customer?
    
    init(dataAccess: ESPMContainerDataAccess , selectedEntity : Customer)
    {
        self.dataAccess = dataAccess
        self.selectedEntity = selectedEntity
    }
    func prepareCellForCustomerEntity(tableview : UITableView, indexPath: IndexPath, cell: FUISimplePropertyFormCell) {
        if(self.selectedEntity?.hasDataValue(for: Customer.customerID))!{
            let row = indexPath.row
            let property = ESPMContainerMetadata.EntityTypes.customer.propertyList[row]
            let value = (self.selectedEntity?.dataValue(for: property))!
            cell.value = "\(value)"
            cell.isEditable = true
            cell.textLabel!.numberOfLines = 0
            cell.textLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell.keyName = property.name
            
            cell.onChangeHandler = { newValue in
                self.selectedEntity?.setOptionalValue(for: property, to: StringValue.of(optional: newValue))
                print((self.selectedEntity?.dataValue(for: property))!)
                
            }
        }else{
            self.prepareCellForCreateCustomer(tableview: tableview, indexPath: indexPath, cell: cell)
        }
    }
    func getEntityCount() -> Int{
        var count = 0
        print(ESPMContainerMetadata.EntityTypes.customer.propertyList.makeIterator())
        for item in ESPMContainerMetadata.EntityTypes.customer.propertyList {
            print(item.name)
            count += 1
        }
        return count;
    }
    func getCustomerID() -> Int{
//        print(ESPMContainerMetadata.EntityTypes.customer.propertyList.max())
//        var maxCustID = 0
//        for item in self.selectedEntity?.customerID {
//            if(item.)
//        }
        return 2;
    }
    
    func prepareCellForCreateCustomer(tableview : UITableView, indexPath: IndexPath, cell: FUISimplePropertyFormCell){
        let row = indexPath.row
        let property = ESPMContainerMetadata.EntityTypes.customer.propertyList[row]
//        if(property.name == ESPMContainerMetadata.EntityTypes.customer.keyProperties[0].name){
//            cell.value = "\(self.getCustomerID)"
//        }
        cell.isEditable = true
        cell.textLabel!.numberOfLines = 0
        cell.textLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.keyName = property.name
        cell.placeholderText    = property.name
        cell.onChangeHandler = { newValue in
            self.selectedEntity?.setOptionalValue(for: property, to: StringValue.of(optional: newValue))
            print((self.selectedEntity?.dataValue(for: property))!)
            
        }
    }
    

}
