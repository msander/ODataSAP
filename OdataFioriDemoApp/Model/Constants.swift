//
//  Constants.swift
//  OdataFioriDemoApp
//
//  Created by Riya Ganguly on 09/06/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import Foundation
import SAPFoundation
import SAPOData

enum CollectionType: String {
    case customers = "Customers"
    case salesOrderHeaders = "SalesOrderHeaders"
    case productTexts = "ProductTexts"
    case suppliers = "Suppliers"
    case purchaseOrderItems = "PurchaseOrderItems"
    case stock = "Stock"
    case productCategories = "ProductCategories"
    case salesOrderItems = "SalesOrderItems"
    case purchaseOrderHeaders = "PurchaseOrderHeaders"
    case products = "Products"
    case none = ""
    
    static let allValues: [CollectionType] = [
        customers, salesOrderHeaders, productTexts, suppliers, purchaseOrderItems, stock, productCategories, salesOrderItems, purchaseOrderHeaders, products]
}

struct Constants {
    
    static let appId = "com.pmico.ODataSampleApp"
    private static let sapcpmsUrlString = "https://hcpms-p1942666446trial.hanatrial.ondemand.com/"
    static let sapcpmsUrl = URL(string: sapcpmsUrlString)!
    static let appUrl = Constants.sapcpmsUrl.appendingPathComponent(appId)
    static let configurationParameters = SAPcpmsSettingsParameters(backendURL: Constants.sapcpmsUrl, applicationID: Constants.appId)
}
