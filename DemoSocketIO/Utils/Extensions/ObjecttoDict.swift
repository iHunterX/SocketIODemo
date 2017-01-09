//
//  ObjecttoDict.swift
//  DemoSocketIO
//
//  Created by Loc.dx-KeizuDev on 11/16/16.
//  Copyright © 2016 Loc Dinh Xuan. All rights reserved.
//

import Foundation


@objc protocol Serializable {
    var jsonProperties:Array<String> { get }
    func valueForKey(key: String!) -> AnyObject!
}

struct Serialize {
    static func toDictionary(obj:Serializable) -> NSDictionary {
        // make dictionary
        var dict = Dictionary<String, Any>()
        
        // add values
        for prop in obj.jsonProperties {
            let val:AnyObject! = obj.valueForKey(key: prop)
            
            if (val is String)
            {
                dict[prop] = val as! String
            }
            else if (val is Int)
            {
                dict[prop] = val as! Int
            }
            else if (val is Double)
            {
                dict[prop] = val as! Double
            }
            else if (val is Array<String>)
            {
                dict[prop] = val as! Array<String>
            }
            else if (val is Serializable)
            {
                dict[prop] = toJSON(obj: val as! Serializable)
            }
            else if (val is Array<Serializable>)
            {
                var arr = Array<NSDictionary>()
                
                for item in (val as! Array<Serializable>) {
                    arr.append(toDictionary(obj: item))
                }
                
                dict[prop] = arr
            }
            
        }
        
        // return dict
        return dict as NSDictionary
    }
    
    static func toJSON(obj:Serializable) -> String {
        // get dict
        let dict = toDictionary(obj: obj)
        
        // make JSON
        let data = try! JSONSerialization.data(withJSONObject: dict, options:[])
        
        // return result
        return NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
    }
}
