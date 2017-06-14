// # Proxy Compiler 1.7.3.17

import Foundation
import SAPOData

open class Supplier: EntityValue {
    public static let city: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "City")

    public static let country: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "Country")

    public static let emailAddress: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "EmailAddress")

    public static let houseNumber: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "HouseNumber")

    public static let phoneNumber: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "PhoneNumber")

    public static let postalCode: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "PostalCode")

    public static let street: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "Street")

    public static let supplierID: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "SupplierId")

    public static let supplierName: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "SupplierName")

    public static let updatedTimestamp: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "UpdatedTimestamp")

    public static let products: Property = ESPMContainerMetadata.EntityTypes.supplier.property(withName: "Products")

    public init() {
        super.init(type: ESPMContainerMetadata.EntityTypes.supplier)
    }

    open class func array(from: EntityValueList) -> Array<Supplier> {
        return ArrayConverter.convert(from.toArray(), Array<Supplier>())
    }

    open var city: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Supplier.city))
        }
        set(value) {
            self.setOptionalValue(for: Supplier.city, to: StringValue.of(optional: value))
        }
    }

    open func copy() -> Supplier {
        return CastRequired<Supplier>.from(self.copyEntity())
    }

    open var country: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Supplier.country))
        }
        set(value) {
            self.setOptionalValue(for: Supplier.country, to: StringValue.of(optional: value))
        }
    }

    open var emailAddress: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Supplier.emailAddress))
        }
        set(value) {
            self.setOptionalValue(for: Supplier.emailAddress, to: StringValue.of(optional: value))
        }
    }

    open var houseNumber: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Supplier.houseNumber))
        }
        set(value) {
            self.setOptionalValue(for: Supplier.houseNumber, to: StringValue.of(optional: value))
        }
    }

    open class func key(supplierID: String?) -> EntityKey {
        return EntityKey().with(name: "SupplierId", value: StringValue.of(optional: supplierID))
    }

    open var old: Supplier {
        get {
            return CastRequired<Supplier>.from(self.oldEntity)
        }
    }

    open var phoneNumber: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Supplier.phoneNumber))
        }
        set(value) {
            self.setOptionalValue(for: Supplier.phoneNumber, to: StringValue.of(optional: value))
        }
    }

    open var postalCode: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Supplier.postalCode))
        }
        set(value) {
            self.setOptionalValue(for: Supplier.postalCode, to: StringValue.of(optional: value))
        }
    }

    open var products: Array<Product> {
        get {
            return ArrayConverter.convert(EntityValueList.castRequired(self.requiredValue(for: Supplier.products)).toArray(), Array<Product>())
        }
        set(value) {
            Supplier.products.setEntityList(in: self, to: EntityValueList.fromArray(ArrayConverter.convert(value, Array<EntityValue>())))
        }
    }

    open var street: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Supplier.street))
        }
        set(value) {
            self.setOptionalValue(for: Supplier.street, to: StringValue.of(optional: value))
        }
    }

    open var supplierID: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Supplier.supplierID))
        }
        set(value) {
            self.setOptionalValue(for: Supplier.supplierID, to: StringValue.of(optional: value))
        }
    }

    open var supplierName: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Supplier.supplierName))
        }
        set(value) {
            self.setOptionalValue(for: Supplier.supplierName, to: StringValue.of(optional: value))
        }
    }

    open var updatedTimestamp: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: Supplier.updatedTimestamp))
        }
        set(value) {
            self.setOptionalValue(for: Supplier.updatedTimestamp, to: value)
        }
    }
}
