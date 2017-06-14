//
//  CustomerDA.swift
//  OdataFioriDemoApp
//
//  Created by Riya Ganguly on 12/06/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import Foundation
import SAPFoundation
import SAPOData
import SAPCommon

class CustomerDA: NSObject {
    
    private var dataAccess : ESPMContainerDataAccess!
    
    private var entities: [Customer] = [Customer]()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override init() {
        super.init()
        self.dataAccess = appDelegate.espmContainer
    }
    func requestEntities(completionHandler: @escaping([EntityValue]?,Error?) -> Void) {
        self.dataAccess.loadCustomers { (customers, error) in
            guard let customers = customers else {
                completionHandler(nil,error!)
                return
            }
            self.entities = customers
            completionHandler(self.entities,nil)
        }
    }
}
