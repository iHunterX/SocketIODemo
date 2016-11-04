//
//  ObjectiveC.swift
//  DemoSocketIO
//
//  Created by Loc.dx-KeizuDev on 11/2/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import Foundation


extension Int64: _ObjectiveCBridgeable {
    
    public typealias _ObjectiveCType = NSNumber
    
    public static func _isBridgedToObjectiveC() -> Bool {
        return true
    }
    
    public static func _getObjectiveCType() -> Any.Type {
        return _ObjectiveCType.self
    }
    
    public func _bridgeToObjectiveC() -> _ObjectiveCType {
        return NSNumber(value: self)
    }
    
    public static func _forceBridgeFromObjectiveC(source: _ObjectiveCType, result: inout Int64?) {
        result = source.int64Value
    }
    
    public static func _conditionallyBridgeFromObjectiveC(source: _ObjectiveCType, result: inout Int64?) -> Bool {
        self._forceBridgeFromObjectiveC(source, result: &result)
        return true
    }
}
