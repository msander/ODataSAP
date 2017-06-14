// # Proxy Compiler 1.7.3.17

import Foundation
import SAPOData

open class ESPMContainer<Provider: DataServiceProvider>: DataService<Provider> {

    public override init(provider: Provider) {
        super.init(provider: provider)
        self.provider.metadata = ESPMContainerMetadata.document
    }

    open func customers(query: DataQuery = DataQuery()) throws -> Array<Customer> {
        return try Customer.array(from: self.executeQuery(query.from(ESPMContainerMetadata.EntitySets.customers)).entityList())
    }

    open func customers(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<Customer>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<Customer> = try self.customers(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func generateSamplePurcharOrders(query: DataQuery = DataQuery()) throws -> Bool? {
        return try BooleanValue.optional(self.executeQuery(query.invoke(ESPMContainerMetadata.ActionImports.generateSamplePurcharOrders, ParameterList.empty)).result)
    }

    open func generateSamplePurcharOrders(query: DataQuery = DataQuery(), completionHandler: @escaping(Bool?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Bool? = try self.generateSamplePurcharOrders(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func generateSampleSalesOrders(query: DataQuery = DataQuery()) throws -> Bool? {
        return try BooleanValue.optional(self.executeQuery(query.invoke(ESPMContainerMetadata.ActionImports.generateSampleSalesOrders, ParameterList.empty)).result)
    }

    open func generateSampleSalesOrders(query: DataQuery = DataQuery(), completionHandler: @escaping(Bool?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Bool? = try self.generateSampleSalesOrders(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func productCategories(query: DataQuery = DataQuery()) throws -> Array<ProductCategory> {
        return try ProductCategory.array(from: self.executeQuery(query.from(ESPMContainerMetadata.EntitySets.productCategories)).entityList())
    }

    open func productCategories(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<ProductCategory>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<ProductCategory> = try self.productCategories(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func productTexts(query: DataQuery = DataQuery()) throws -> Array<ProductText> {
        return try ProductText.array(from: self.executeQuery(query.from(ESPMContainerMetadata.EntitySets.productTexts)).entityList())
    }

    open func productTexts(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<ProductText>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<ProductText> = try self.productTexts(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func products(query: DataQuery = DataQuery()) throws -> Array<Product> {
        return try Product.array(from: self.executeQuery(query.from(ESPMContainerMetadata.EntitySets.products)).entityList())
    }

    open func products(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<Product>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<Product> = try self.products(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func purchaseOrderHeaders(query: DataQuery = DataQuery()) throws -> Array<PurchaseOrderHeader> {
        return try PurchaseOrderHeader.array(from: self.executeQuery(query.from(ESPMContainerMetadata.EntitySets.purchaseOrderHeaders)).entityList())
    }

    open func purchaseOrderHeaders(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<PurchaseOrderHeader>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<PurchaseOrderHeader> = try self.purchaseOrderHeaders(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func purchaseOrderItems(query: DataQuery = DataQuery()) throws -> Array<PurchaseOrderItem> {
        return try PurchaseOrderItem.array(from: self.executeQuery(query.from(ESPMContainerMetadata.EntitySets.purchaseOrderItems)).entityList())
    }

    open func purchaseOrderItems(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<PurchaseOrderItem>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<PurchaseOrderItem> = try self.purchaseOrderItems(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func resetSampleData(query: DataQuery = DataQuery()) throws -> Bool? {
        return try BooleanValue.optional(self.executeQuery(query.invoke(ESPMContainerMetadata.ActionImports.resetSampleData, ParameterList.empty)).result)
    }

    open func resetSampleData(query: DataQuery = DataQuery(), completionHandler: @escaping(Bool?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Bool? = try self.resetSampleData(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func salesOrderHeaders(query: DataQuery = DataQuery()) throws -> Array<SalesOrderHeader> {
        return try SalesOrderHeader.array(from: self.executeQuery(query.from(ESPMContainerMetadata.EntitySets.salesOrderHeaders)).entityList())
    }

    open func salesOrderHeaders(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<SalesOrderHeader>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<SalesOrderHeader> = try self.salesOrderHeaders(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func salesOrderItems(query: DataQuery = DataQuery()) throws -> Array<SalesOrderItem> {
        return try SalesOrderItem.array(from: self.executeQuery(query.from(ESPMContainerMetadata.EntitySets.salesOrderItems)).entityList())
    }

    open func salesOrderItems(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<SalesOrderItem>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<SalesOrderItem> = try self.salesOrderItems(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func stock(query: DataQuery = DataQuery()) throws -> Array<Stock> {
        return try Stock.array(from: self.executeQuery(query.from(ESPMContainerMetadata.EntitySets.stock)).entityList())
    }

    open func stock(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<Stock>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<Stock> = try self.stock(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func suppliers(query: DataQuery = DataQuery()) throws -> Array<Supplier> {
        return try Supplier.array(from: self.executeQuery(query.from(ESPMContainerMetadata.EntitySets.suppliers)).entityList())
    }

    open func suppliers(query: DataQuery = DataQuery(), completionHandler: @escaping(Array<Supplier>?, Error?) -> Void) -> Void {
        self.addBackgroundOperation {
            do {
                let result: Array<Supplier> = try self.suppliers(query: query)
                OperationQueue.main.addOperation {
                    completionHandler(result, nil)
                }
            }
            catch let error {
                OperationQueue.main.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }
}
