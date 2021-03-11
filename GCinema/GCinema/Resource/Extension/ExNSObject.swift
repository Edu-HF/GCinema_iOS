//
//  ExNSObject.swift
//  GCinema
//
//  Created by Edu on 06/03/21.
//

import Foundation

extension NSObject {
    
    func mLog(_ items: Any..., separator: String = " ", terminator: String = "\n", inRelease: Bool = false) {
        
        if inRelease {
            print(items, separator, terminator)
        }else{
            #if DEBUG
            print(items, separator, terminator)
            #endif
        }
    }
    
    func makeDecode<T: Codable>(_ typeIn: T.Type, _ dataIn: Data) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            return try jsonDecoder.decode(typeIn, from: dataIn)
        } catch {
            return makeDecodeWithFragments(dataIn)
        }
    }
    
    func makeDecodeWithFragments<T: Codable>(_ dataIn: Data) -> T? {
        do {
            return try JSONSerialization.jsonObject(with: dataIn, options: .allowFragments) as? T
        } catch {
            return nil
        }
    }
    
    func makeAnyDecode<T: Codable>(_ typeIn: T.Type, _ anyIn: Any) -> T? {
        do {
            guard let mData = try? JSONSerialization.data(withJSONObject: anyIn, options: .fragmentsAllowed) else { return nil }
            return try JSONDecoder().decode(typeIn, from: mData)
        } catch {
            return nil
        }
    }
    
}

extension Encodable {
    
    var toDictionary: [String : Any]? {
        
        guard let mData = try? JSONEncoder().encode(self) else { return nil }
        return try? JSONSerialization.jsonObject(with: mData, options: .allowFragments) as? [String : Any]
    }
}

