//
//  OfflineODataDel.swift
//  OdataFioriDemoApp
//
//  Created by Sayantan Chakraborty on 27/06/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import Foundation
import SAPOfflineOData
import SAPCommon
import SAPFoundation

class OfflineODataDel :OfflineODataDelegate {
    
    public func offlineODataProvider( _ provider: OfflineODataProvider, didUpdateDownloadProgress progress: OfflineODataProgress ) -> Void
        
    {
        print( "downloadProgress: \(progress.bytesSent)  \(progress.bytesReceived)" )
    }
    
    public func offlineODataProvider( _ provider: OfflineODataProvider, didUpdateFileDownloadProgress progress: OfflineODataFileDownloadProgress ) -> Void
    {
        print( "downloadProgress: \(progress.bytesReceived)  \(progress.fileSize)" )
    }
    
    public func offlineODataProvider( _ provider: OfflineODataProvider, didUpdateUploadProgress progress: OfflineODataProgress ) -> Void
    {
        print( "downloadProgress: \(progress.bytesSent)  \(progress.bytesReceived)" )
    }
    
    public func offlineODataProvider( _ provider: OfflineODataProvider, requestDidFail request: OfflineODataFailedRequest ) -> Void
    {
        print( "requestFailed: \(request.httpStatusCode)" )
    }
    func offlineODataProvider(_ provider: OfflineODataProvider, stateDidChange newState: OfflineODataStoreState) {
        let stateString = storeState2String( newState )
        print( "stateChanged: \(stateString)" )
    }
    
    private func storeState2String( _ state : OfflineODataStoreState ) -> String
    {
        var result = ""
        if state.contains(.opening) {
            result = result + ":opening"
        }
        
        if state.contains(.open) {
            result = result + ":open"
        }
        
        if state.contains(.closed) {
            result = result + ":closed"
        }
        
        if state.contains(.downloading) {
            result = result + ":downloading"
        }
        
        if state.contains(.uploading) {
            result = result + ":uploading"
        }
        
        if state.contains(.initializing) {
            result = result + ":initializing"
        }
        
        if state.contains(.fileDownloading) {
            result = result + ":fileDownloading"
        }
        
        if state.contains(.initialCommunication) {
            result = result + ":initialCommunication"
        }
        
        return result
        
    }


}
