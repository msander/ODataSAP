// # Proxy Compiler 1.7.3.17

import Foundation
import SAPOData

open class PurchaseOrderItem: EntityValue {
    public static let currencyCode: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "CurrencyCode")

    public static let grossAmount: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "GrossAmount")

    public static let netAmount: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "NetAmount")

    public static let productID: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "ProductId")

    public static let itemNumber: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "ItemNumber")

    public static let purchaseOrderID: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "PurchaseOrderId")

    public static let quantity: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "Quantity")

    public static let quantityUnit: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "QuantityUnit")

    public static let taxAmount: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "TaxAmount")

    public static let productDetails: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "ProductDetails")

    public static let header: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderItem.property(withName: "Header")

    public init() {
        super.init(type: ESPMContainerMetadata.EntityTypes.purchaseOrderItem)
    }

    open class func array(from: EntityValueList) -> Array<PurchaseOrderItem> {
        return ArrayConverter.convert(from.toArray(), Array<PurchaseOrderItem>())
    }

    open func copy() -> PurchaseOrderItem {
        return CastRequired<PurchaseOrderItem>.from(self.copyEntity())
    }

    open var currencyCode: String? {
        get {
            return StringValue.optional(self.optionalValue(for: PurchaseOrderItem.currencyCode))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderItem.currencyCode, to: StringValue.of(optional: value))
        }
    }

    open var grossAmount: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: PurchaseOrderItem.grossAmount))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderItem.grossAmount, to: DecimalValue.of(optional: value))
        }
    }

    open var header: PurchaseOrderHeader {
        get {
            return CastRequired<PurchaseOrderHeader>.from(self.optionalValue(for: PurchaseOrderItem.header))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderItem.header, to: value)
        }
    }

    open var itemNumber: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: PurchaseOrderItem.itemNumber))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderItem.itemNumber, to: IntValue.of(optional: value))
        }
    }

    open class func key(itemNumber: Int?, purchaseOrderID: String?) -> EntityKey {
        return EntityKey().with(name: "ItemNumber", value: IntValue.of(optional: itemNumber)).with(name: "PurchaseOrderId", value: StringValue.of(optional: purchaseOrderID))
    }

    open var netAmount: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: PurchaseOrderItem.netAmount))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderItem.netAmount, to: DecimalValue.of(optional: value))
        }
    }

    open var old: PurchaseOrderItem {
        get {
            return CastRequired<PurchaseOrderItem>.from(self.oldEntity)
        }
    }

    open var productDetails: Product {
        get {
            return CastRequired<Product>.from(self.optionalValue(for: PurchaseOrderItem.productDetails))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderItem.productDetails, to: value)
        }
    }

    open var productID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: PurchaseOrderItem.productID))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderItem.productID, to: StringValue.of(optional: value))
        }
    }

    open var purchaseOrderID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: PurchaseOrderItem.purchaseOrderID))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderItem.purchaseOrderID, to: StringValue.of(optional: value))
        }
    }

    open var quantity: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: PurchaseOrderItem.quantity))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderItem.quantity, to: DecimalValue.of(optional: value))
        }
    }

    open var quantityUnit: String? {
        get {
            return StringValue.optional(self.optionalValue(for: PurchaseOrderItem.quantityUnit))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderItem.quantityUnit, to: StringValue.of(optional: value))
        }
    }

    open var taxAmount: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: PurchaseOrderItem.taxAmount))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderItem.taxAmount, to: DecimalValue.of(optional: value))
        }
    }
}
