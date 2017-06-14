// # Proxy Compiler 1.7.3.17

import Foundation
import SAPOData

open class PurchaseOrderHeader: EntityValue {
    public static let currencyCode: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderHeader.property(withName: "CurrencyCode")

    public static let grossAmount: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderHeader.property(withName: "GrossAmount")

    public static let netAmount: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderHeader.property(withName: "NetAmount")

    public static let purchaseOrderID: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderHeader.property(withName: "PurchaseOrderId")

    public static let supplierID: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderHeader.property(withName: "SupplierId")

    public static let taxAmount: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderHeader.property(withName: "TaxAmount")

    public static let items: Property = ESPMContainerMetadata.EntityTypes.purchaseOrderHeader.property(withName: "Items")

    public init() {
        super.init(type: ESPMContainerMetadata.EntityTypes.purchaseOrderHeader)
    }

    open class func array(from: EntityValueList) -> Array<PurchaseOrderHeader> {
        return ArrayConverter.convert(from.toArray(), Array<PurchaseOrderHeader>())
    }

    open func copy() -> PurchaseOrderHeader {
        return CastRequired<PurchaseOrderHeader>.from(self.copyEntity())
    }

    open var currencyCode: String? {
        get {
            return StringValue.optional(self.optionalValue(for: PurchaseOrderHeader.currencyCode))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderHeader.currencyCode, to: StringValue.of(optional: value))
        }
    }

    open var grossAmount: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: PurchaseOrderHeader.grossAmount))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderHeader.grossAmount, to: DecimalValue.of(optional: value))
        }
    }

    open var items: Array<PurchaseOrderItem> {
        get {
            return ArrayConverter.convert(EntityValueList.castRequired(self.requiredValue(for: PurchaseOrderHeader.items)).toArray(), Array<PurchaseOrderItem>())
        }
        set(value) {
            PurchaseOrderHeader.items.setEntityList(in: self, to: EntityValueList.fromArray(ArrayConverter.convert(value, Array<EntityValue>())))
        }
    }

    open class func key(purchaseOrderID: String?) -> EntityKey {
        return EntityKey().with(name: "PurchaseOrderId", value: StringValue.of(optional: purchaseOrderID))
    }

    open var netAmount: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: PurchaseOrderHeader.netAmount))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderHeader.netAmount, to: DecimalValue.of(optional: value))
        }
    }

    open var old: PurchaseOrderHeader {
        get {
            return CastRequired<PurchaseOrderHeader>.from(self.oldEntity)
        }
    }

    open var purchaseOrderID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: PurchaseOrderHeader.purchaseOrderID))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderHeader.purchaseOrderID, to: StringValue.of(optional: value))
        }
    }

    open var supplierID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: PurchaseOrderHeader.supplierID))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderHeader.supplierID, to: StringValue.of(optional: value))
        }
    }

    open var taxAmount: BigDecimal? {
        get {
            return DecimalValue.optional(self.optionalValue(for: PurchaseOrderHeader.taxAmount))
        }
        set(value) {
            self.setOptionalValue(for: PurchaseOrderHeader.taxAmount, to: DecimalValue.of(optional: value))
        }
    }
}
