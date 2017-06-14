// # Proxy Compiler 1.7.3.17

import Foundation
import SAPOData

open class ProductCategory: EntityValue {
    public static let category: Property = ESPMContainerMetadata.EntityTypes.productCategory.property(withName: "Category")

    public static let categoryName: Property = ESPMContainerMetadata.EntityTypes.productCategory.property(withName: "CategoryName")

    public static let mainCategory: Property = ESPMContainerMetadata.EntityTypes.productCategory.property(withName: "MainCategory")

    public static let mainCategoryName: Property = ESPMContainerMetadata.EntityTypes.productCategory.property(withName: "MainCategoryName")

    public static let numberOfProducts: Property = ESPMContainerMetadata.EntityTypes.productCategory.property(withName: "NumberOfProducts")

    public static let updatedTimestamp: Property = ESPMContainerMetadata.EntityTypes.productCategory.property(withName: "UpdatedTimestamp")

    public init() {
        super.init(type: ESPMContainerMetadata.EntityTypes.productCategory)
    }

    open class func array(from: EntityValueList) -> Array<ProductCategory> {
        return ArrayConverter.convert(from.toArray(), Array<ProductCategory>())
    }

    open var category: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ProductCategory.category))
        }
        set(value) {
            self.setOptionalValue(for: ProductCategory.category, to: StringValue.of(optional: value))
        }
    }

    open var categoryName: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ProductCategory.categoryName))
        }
        set(value) {
            self.setOptionalValue(for: ProductCategory.categoryName, to: StringValue.of(optional: value))
        }
    }

    open func copy() -> ProductCategory {
        return CastRequired<ProductCategory>.from(self.copyEntity())
    }

    open class func key(category: String?) -> EntityKey {
        return EntityKey().with(name: "Category", value: StringValue.of(optional: category))
    }

    open var mainCategory: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ProductCategory.mainCategory))
        }
        set(value) {
            self.setOptionalValue(for: ProductCategory.mainCategory, to: StringValue.of(optional: value))
        }
    }

    open var mainCategoryName: String? {
        get {
            return StringValue.optional(self.optionalValue(for: ProductCategory.mainCategoryName))
        }
        set(value) {
            self.setOptionalValue(for: ProductCategory.mainCategoryName, to: StringValue.of(optional: value))
        }
    }

    open var numberOfProducts: Int64? {
        get {
            return LongValue.optional(self.optionalValue(for: ProductCategory.numberOfProducts))
        }
        set(value) {
            self.setOptionalValue(for: ProductCategory.numberOfProducts, to: LongValue.of(optional: value))
        }
    }

    open var old: ProductCategory {
        get {
            return CastRequired<ProductCategory>.from(self.oldEntity)
        }
    }

    open var updatedTimestamp: LocalDateTime? {
        get {
            return LocalDateTime.castOptional(self.optionalValue(for: ProductCategory.updatedTimestamp))
        }
        set(value) {
            self.setOptionalValue(for: ProductCategory.updatedTimestamp, to: value)
        }
    }
}
