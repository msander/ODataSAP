//
//  ProductDA.swift
//  OdataFioriDemoApp
//
//  Created by Sayantan Chakraborty on 14/06/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import Foundation
import SAPFoundation
import SAPOData
import SAPCommon

class ProductDA {
    
    private var dataAccess : ESPMContainerDataAccess!
    
    private var entities: [Product] = [Product]()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    init() {
        self.dataAccess = appDelegate.espmContainer
    }
    func requestEntities(completionHandler: @escaping([EntityValue]?,Error?) -> Void) {
        self.dataAccess.loadProducts { (products, error) in
            guard let product = products else {
                completionHandler(nil,error! as? Error)
                return
            }
            self.entities = product
            completionHandler(self.entities,nil)
        }
    }
}
