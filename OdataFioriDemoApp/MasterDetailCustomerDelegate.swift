//
//  MasterDetailCustomerDelegate.swift
//  OdataFioriDemoApp
//
//  Created by Sayantan Chakraborty on 15/06/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import Foundation
protocol MasterDetailCustomerDelegate: class {
    func showDetail(type: CollectionType)
}
