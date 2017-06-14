//
//  SalesOrderHeaderDA.swift
//  OdataFioriDemoApp
//
//  Created by Riya Ganguly on 09/06/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import Foundation
import SAPFoundation
import SAPOData
import SAPCommon

class SalesOrderHeaderDA {
    
    private var dataAccess : ESPMContainerDataAccess!
    
    private var entities: [SalesOrderHeader] = [SalesOrderHeader]()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    init() {
        self.dataAccess = appDelegate.espmContainer
    }
    func requestEntities(completionHandler: @escaping([EntityValue]?,Error?) -> Void) {
        self.dataAccess.loadSalesOrderHeaders { (salesorderheaders, error) in
            guard let salesorderheaders = salesorderheaders else {
                completionHandler(nil,error!)
                return
            }
            self.entities = salesorderheaders
            completionHandler(self.entities,nil)
        }
    }
}
