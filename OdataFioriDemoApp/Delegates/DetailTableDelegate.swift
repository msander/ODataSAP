//
//  DetailTableDelegate.swift
//  OdataFioriDemoApp
//
//  Created by Riya Ganguly on 12/06/17.
//  Copyright © 2017 SAP. All rights reserved.
//

import SAPOData
import SAPFiori

protocol DetailTableDelegate: UITableViewDelegate, UITableViewDataSource {
    var entity: EntityValue { get set }
}
extension DetailTableDelegate {
    func defaultValueFor(_ property: Property) -> Double {
        if let defaultValue = property.defaultValue {
            return Double(defaultValue.toString())!
        } else {
            return Double()
        }
    }
    
    func defaultValueFor(_ property: Property) -> BigDecimal {
        if let defaultValue = property.defaultValue {
            return (defaultValue as! DecimalValue).value
        } else {
            return BigDecimal.fromDouble(Double())
        }
    }
    
    func defaultValueFor(_ property: Property) -> Int {
        if let defaultValue = property.defaultValue {
            return Int(defaultValue.toString())!
        } else {
            return Int()
        }
    }
    
    func defaultValueFor(_ property: Property) -> BigInteger {
        if let defaultValue = property.defaultValue {
            return BigInteger(defaultValue.toString())
        } else {
            return BigInteger.fromInt(Int())
        }
    }
    
    func defaultValueFor(_ property: Property) -> Int64 {
        if let defaultValue = property.defaultValue {
            return Int64(defaultValue.toString())!
        } else {
            return Int64()
        }
    }
    
    func defaultValueFor(_ property: Property) -> Float {
        if let defaultValue = property.defaultValue {
            return Float(defaultValue.toString())!
        } else {
            return Float()
        }
    }
    
    func defaultValueFor(_ property: Property) -> LocalDateTime {
        if let defaultValue = property.defaultValue {
            return LocalDateTime.parse(defaultValue.toString())!
        } else {
            return LocalDateTime.now()
        }
    }
    
    func defaultValueFor(_ property: Property) -> GlobalDateTime {
        if let defaultValue = property.defaultValue {
            return GlobalDateTime.parse(defaultValue.toString())!
        } else {
            return GlobalDateTime.now()
        }
    }
    
    func defaultValueFor(_ property: Property) -> GuidValue {
        if let defaultValue = property.defaultValue {
            return GuidValue.parse(defaultValue.toString())!
        } else {
            return GuidValue.random()
        }
    }
    
    func defaultValueFor(_ property: Property) -> String {
        if let defaultValue = property.defaultValue {
            return defaultValue.toString()
        } else {
            return ""
        }
    }
    
//    func defaultValueFor(_ property: Property) -> Bool {
//        if let defaultValue = property.defaultValue {
//            return defaultValue.toString().toBool()!
//        } else {
//            return Bool()
//        }
//    }
}
//extension DetailViewController {
//    
//    func generatedTableDelegate() -> DetailTableDelegate? {
//        switch self.collectionType {
//            case .customers:
//                return CustomerDetailView(dataAccess:self.espmContainer)
//            default:
//                return nil
//        }
//    }
//}
