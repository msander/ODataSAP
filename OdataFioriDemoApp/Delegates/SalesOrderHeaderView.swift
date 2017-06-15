//
//  SalesOrderHeaderView.swift
//  OdataFioriDemoApp
//
//  Created by Riya Ganguly on 15/06/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import Foundation
import UIKit
import SAPOData
import SAPCommon
import SAPFiori

class SalesOrderHeaderView{
    let dataAccess: ESPMContainerDataAccess!
    var selectedEntity: SalesOrderHeader?
    
    init(dataAccess: ESPMContainerDataAccess , selectedEntity : SalesOrderHeader)
    {
        self.dataAccess = dataAccess
        self.selectedEntity = selectedEntity
    }
    func getEntityCount() -> Int{
        var count = 0
        print(ESPMContainerMetadata.EntityTypes.salesOrderHeader.propertyList.makeIterator())
        for item in ESPMContainerMetadata.EntityTypes.salesOrderHeader.propertyList {
            if(!(item.name == "CustomerDetails" || item.name == "Items")){
                print(item.name)
                count += 1
            }
        }
        return count;
    }
    
    func prepareCellForSalesOrderHeaderEntity(tableview : UITableView, indexPath: IndexPath, cell: FUISimplePropertyFormCell) {
        if(self.selectedEntity?.hasDataValue(for: SalesOrderHeader.salesOrderID))!{
            let row = indexPath.row
            let property = ESPMContainerMetadata.EntityTypes.salesOrderHeader.propertyList[row]
            
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
            self.prepareCellForCreateSalesOrderHeader(tableview: tableview, indexPath: indexPath, cell: cell)
        }
    }
    
    func prepareCellForCreateSalesOrderHeader(tableview : UITableView, indexPath: IndexPath, cell: FUISimplePropertyFormCell){
        let row = indexPath.row
        let property = ESPMContainerMetadata.EntityTypes.salesOrderHeader.propertyList[row]
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
