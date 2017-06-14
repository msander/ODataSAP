//
//  ESPMContainerDataAccess.swift
//  OdataFioriDemoApp
//
//  Created by Riya Ganguly on 09/06/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import Foundation
import SAPCommon
import SAPFoundation
import SAPOData
import SAPOfflineOData

class ESPMContainerDataAccess {
    var service: ESPMContainer<OnlineODataProvider>
    var offlineService: ESPMContainer<OfflineODataProvider>
    private(set) var isOfflineStoreOpened = false
    
    init(urlSession: SAPURLSession) {
        let odataProvider = OnlineODataProvider(serviceName: "myServiceName", serviceRoot: Constants.appUrl, sapURLSession: urlSession)
        odataProvider.serviceOptions.checkVersion = false // this disables version validation of the backend OData service and should only be used in demo and test applications
        self.service = ESPMContainer(provider: odataProvider)
        // To update entity force to use X-HTTP-Method header
        _ = self.service.provider.networkOptions.tunneledMethods.append("MERGE")
        
        /// defining Request for offline
        /// initialise the OfflineODataParameters which
        var offlineParameters = OfflineODataParameters()
        offlineParameters.customHeaders = ["X-SMP-APPID":Constants.appId]
        let offlineODataProvider = try! OfflineODataProvider(serviceRoot: URL(string: Constants.appUrl.absoluteString)!, parameters: offlineParameters, sapURLSession: urlSession)
        
        /// define the initial set of Data, the AppID and the Offline OData Provider for the store
        try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(
            name: CollectionType.customers.rawValue,
            query: "/\(CollectionType.customers.rawValue)",
            automaticallyRetrievesStreams: false))
        
        try! offlineODataProvider.add(definingQuery: OfflineODataDefiningQuery(
            name: CollectionType.salesOrderHeaders.rawValue,
             query: "/\(CollectionType.salesOrderHeaders.rawValue)",
            automaticallyRetrievesStreams: false))
        
        offlineService = ESPMContainer(provider: offlineODataProvider)
        self.openOfflineStore{_ in }
    }
    
    /// opens the offline store. if store does not exists it will trigger the initial download of the store and create the local DB
    ///
    /// - Returns: returns the status
    func openOfflineStore(completionHandler: @escaping (String) -> Void) {
        guard !isOfflineStoreOpened else {
            completionHandler("Offline store opened.")
            return
        }
        /// The OfflineODataProvider needs to be opened before performing any operations.
        
        offlineService.open { error in
            if let error = error {
                completionHandler("Could not open offline store. \(error.localizedDescription)")
                return
            }
            self.isOfflineStoreOpened = true
            completionHandler("Offline store opened.")
        }
    }
    
    /// closes the offline store
    ///
    /// - Returns: returns the status
    func closeOfflineStore() -> String {
        if isOfflineStoreOpened {
            do {
                /// the Offline store should be closed when it is no longer used.
                try offlineService.close()
                isOfflineStoreOpened = false
            } catch {
                return String("Offline Store closing failed")
            }
        }
        return String("Offline Store closed")
    }
    func loadSalesOrderHeaders(completionHandler: @escaping([SalesOrderHeader]?, Error?) -> Void) {
        let query = DataQuery().selectAll().top(20)
        if isOfflineStoreOpened {
            /// the same query as it was set up for the online use can be fired against the initialised the offline Odata Service
            offlineService.salesOrderHeaders(query: query) { salesOrders, error in
                if let error = error {
                    completionHandler(nil, error)
                    return
                }
                completionHandler(salesOrders!, nil)
            }
        } else {
            service.salesOrderHeaders(query: query) { salesOrders, error in
                if let error = error {
                    completionHandler(nil, error)
                    return
                }
                completionHandler(salesOrders!, nil)
            }
        }

    }
    func loadCustomers(completionHandler: @escaping([Customer]?, Error?) -> Void){
        let query = DataQuery().selectAll().top(20)
        if isOfflineStoreOpened {
            /// the same query as it was set up for the online use can be fired against the initialised the offline Odata Service
            offlineService.customers(query: query) { customers, error in
                if let error = error {
                    completionHandler(nil, error)
                    return
                }
                completionHandler(customers!, nil)
            }
        } else {
            service.customers(query: query) { customers, error in
                if let error = error {
                    completionHandler(nil, error)
                    return
                }
                completionHandler(customers!, nil)
            }
        }
    }
    /// uploads all local changes to the server
    ///
    /// - Returns: returns the status
    func uploadOfflineStore(completionHandler: @escaping (String) -> Void) {
        DispatchQueue.global().async {
            if !self.isOfflineStoreOpened {
                    completionHandler("Offline Store still closed")
                    return
                }
                /// the update function update the client’s backend through SAP HCPms
                self.offlineService.upload { error in
                    if let error = error {
                        completionHandler("Offline Store upload failed \(error.localizedDescription)")
                        return
                    }
                    completionHandler("Offline Store has uploaded")
                }
        }
    }
    
    /// downloads all deltas from the server to update the local store
    ///
    /// - Returns: returns the status
    func downloadOfflineStore(completionHandler: @escaping (String) -> Void) {
        if !isOfflineStoreOpened {
            completionHandler("Offline Store still closed")
            return
        }
        /// the download function update the client’s offline store from the backend.
        self.offlineService.download { error in
            if let error = error {
                completionHandler("Offline Store download failed \(error.localizedDescription)")
                return
            }
            completionHandler("Offline Store is downloaded")
        }
    }
    
    /*
    // -------DataRequesterForEntity: SalesOrderHeaders -------
    func loadSalesOrderHeaders(completionHandler: @escaping([SalesOrderHeader]?, Error?) -> Void) {
        self.executeRequest(self.service.salesOrderHeaders, completionHandler: completionHandler)
    }
    func loadCustomers(completionHandler: @escaping([Customer]?, Error?) -> Void){
        self.executeRequest(self.service.customers, completionHandler: completionHandler)
    }
    private func executeRequest<T>(_ request: @escaping(DataQuery) throws -> [T], completionHandler: @escaping([T]?, Error?) -> Void) {
        DispatchQueue.global().async {
            let query = DataQuery().selectAll().top(20)
            do {
                let result = try request(query)
                completionHandler(result, nil)
            } catch let error {
                
                print("Error happened in the downloading process. Error: \(error)")
                completionHandler(nil, error)
            }
        }
    }*/
    
}
