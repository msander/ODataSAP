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

class CustomerDA {
    
    private var dataAccess : ESPMContainerDataAccess!
    
    private var entities: [Customer] = [Customer]()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    init() {
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
    
    func requestEntitiesFromJSON(completionHandler: @escaping([EntityValue]?,Error?) -> Void){
        let customers = getJSONCustomerData()
        completionHandler(customers,nil)
    }
    
    fileprivate func getJSONCustomerData() -> [EntityValue]{
        var dict = [String:String]()
        var customers = [EntityValue]()
        var propertyListForamt =  PropertyListSerialization.PropertyListFormat.xml
        if let path = Bundle.main.path(forResource: "Customers", ofType: "plist"){
            let plistXML = FileManager.default.contents(atPath: path)
            do{
                dict = try PropertyListSerialization.propertyList(from: plistXML!, options: .mutableContainersAndLeaves, format: &propertyListForamt) as! [String : String]
                let plistData = dict["Customers"]?.data(using: .utf8)
//                let customerData = plistData?.components(separatedBy: ",")
//                print(customerData)
                
                
                let jsonResult = try JSONSerialization.jsonObject(with: plistData!, options: [])
                
                for item in jsonResult as! [Dictionary<String, Any>]{
                    let cus = Customer()
                    cus.dateOfBirth = item["DateOfBirth"] as? LocalDateTime
                    cus.emailAddress = item["EmailAddress"] as? String
                    cus.street = item["Street"] as? String
                    cus.firstName = item["FirstName"]as? String
                    cus.updatedTimestamp = item["UpdatedTimestamp"] as? LocalDateTime
                    cus.phoneNumber = item["PhoneNumber"] as? String
                    cus.lastName = item["LastName"] as? String
                    cus.city = item["City"] as? String
                    cus.country = item["Country"] as? String
                    cus.houseNumber = item["HouseNumber"] as? String
                    cus.customerID = item["CustomerId"] as? String
                    cus.postalCode = item["PostalCode"] as? String
                    
                    customers.append(cus)
                    
                    print(item)
                }
                
                
            }catch {
                print("error\(error.localizedDescription)")
            }
        }
        return customers
    }
}
