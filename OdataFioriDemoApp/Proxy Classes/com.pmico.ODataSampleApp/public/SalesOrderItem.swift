// # Proxy Compiler 1.7.3.17

import Foundation
import SAPOData

open class SalesOrderItem: EntityValue {
    public static let currencyCode: Property = ESPMContainerMetadata.EntityTypes.salesOrderItem.property(withName: "CurrencyCode")

    public static let deliveryDate: Property = ESPMContainerMetadata.EntityTypes.salesOrderItem.property(withName: "DeliveryDate")

    public static let grossAmount: Property = ESPMContainerMetadata.EntityTypes.salesOrderItem.property(withName: "GrossAmount")

    public static let itemNumber: Property = ESPMContainerMetadata.EntityTypes.salesOrderItem.property(withName: "ItemNumber")

    public static let salesOrderID: Property = ESPMContainerMetadata.EntityTypes.salesOrderItem.property(withName: "SalesOrderId")

    public static let netAmount: Property = ESPMContainerMetadata.EntityTypes.salesOrderItem.property(withName: "NetAmount")

    public static let productID: Property = ESPMContainerMetadata.EntityTypes.salesOrderItem.property(withName: "ProductId")

    public static let quantity: Property = ESPMContainerMetadata.EntityTypes.salesOrderItem.property(withName: "Quantity")

    public static let quantityUnit: Property = ESPMContainerMetadata.EntityTypes.salesOrderItem.property(withName: "QuantityUnit")

    public static let taxAmount: Property = ESPMContainerMetadata.EntityTypes.salesOrderItem.property(withName: "TaxAmount")

    public static let productDetails: Property = ESPMContainerMetadata.EntityTypes.salesOrderItem.property(withName: "ProductDetails")

    public static let header: Property = ESPMContainerMetadata.EntityTypes.salesOrderItem.property(withName: "Header")

    public init() {
        super.init(type: ESPMContainerMetadata.EntityTypes.salesOrderItem)
    }

    open class func array(from: EntityValueList) -> Array<SalesOrderItem> {
        return ArrayConverter.convert(from.toArray(), Array<SalesOrderItem>())
    }

    open func copy() -> SalesOrderItem {
        return CastRequired<SalesOrderItem>.from(self.copyEntity())
    }

    open var currencyCode: String? {
        get {
            return StringValue.optional(self.optionalValue(for: SalesOrderItem.currencyCode))
        }
        set(value) {
            self.setOptionalValue(for: SalesOrderItem.currencyCode, to: StringValue.of(optional: value))
        }
    }

    open var deliveryDate: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: SalesOrderItem.deliveryDate))
        }
        set(value) {
            self.setOptionalValue(for: SalesOrderItem.deliveryDate, to: value)
        }
    }

    open var grossAmount: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: SalesOrderItem.grossAmount))
        }
        set(value) {
            self.setOptionalValue(for: SalesOrderItem.grossAmount, to: DecimalValue.of(optional: value))
        }
    }

    open var header: SalesOrderHeader {
        get {
            return CastRequired<SalesOrderHeader>.from(self.optionalValue(for: SalesOrderItem.header))
        }
        set(value) {
            self.setOptionalValue(for: SalesOrderItem.header, to: value)
        }
    }

    open var itemNumber: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: SalesOrderItem.itemNumber))
        }
        set(value) {
            self.setOptionalValue(for: SalesOrderItem.itemNumber, to: IntValue.of(optional: value))
        }
    }

    open class func key(itemNumber: Int?, salesOrderID: String?) -> EntityKey {
        return EntityKey().with(name: "ItemNumber", value: IntValue.of(optional: itemNumber)).with(name: "SalesOrderId", value: StringValue.of(optional: salesOrderID))
    }

    open var netAmount: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: SalesOrderItem.netAmount))
        }
        set(value) {
            self.setOptionalValue(for: SalesOrderItem.netAmount, to: DecimalValue.of(optional: value))
        }
    }

    open var old: SalesOrderItem {
        get {
            return CastRequired<SalesOrderItem>.from(self.oldEntity)
        }
    }

    open var productDetails: Product {
        get {
            return CastRequired<Product>.from(self.optionalValue(for: SalesOrderItem.productDetails))
        }
        set(value) {
            self.setOptionalValue(for: SalesOrderItem.productDetails, to: value)
        }
    }

    open var productID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: SalesOrderItem.productID))
        }
        set(value) {
            self.setOptionalValue(for: SalesOrderItem.productID, to: StringValue.of(optional: value))
        }
    }

    open var quantity: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: SalesOrderItem.quantity))
        }
        set(value) {
            self.setOptionalValue(for: SalesOrderItem.quantity, to: DecimalValue.of(optional: value))
        }
    }

    open var quantityUnit: String? {
        get {
            return StringValue.optional(self.optionalValue(for: SalesOrderItem.quantityUnit))
        }
        set(value) {
            self.setOptionalValue(for: SalesOrderItem.quantityUnit, to: StringValue.of(optional: value))
        }
    }

    open var salesOrderID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: SalesOrderItem.salesOrderID))
        }
        set(value) {
            self.setOptionalValue(for: SalesOrderItem.salesOrderID, to: StringValue.of(optional: value))
        }
    }

    open var taxAmount: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: SalesOrderItem.taxAmount))
        }
        set(value) {
            self.setOptionalValue(for: SalesOrderItem.taxAmount, to: DecimalValue.of(optional: value))
        }
    }
}
