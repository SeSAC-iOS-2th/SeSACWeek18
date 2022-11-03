//
//  SubscriptExample.swift
//  SeSACWeek18
//
//  Created by 이중원 on 2022/11/03.
//

import Foundation

extension String {
    
    //joong >>> [1] >>> o
    
    //옵셔널인 이유: IndexOutOfRange
    subscript(idx: Int) -> String? {
            
        guard (0..<count).contains(idx) else {
            return nil
        }
        
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
    }
    
}

extension Collection {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}

// let a = [Phone(), Phone()]

struct Phone {
    
    var numbers = ["1234", "5678", "4321", "8765"]
    
    subscript(idx: Int) -> String {
        get {
            return self.numbers[idx]
        } set {
            self.numbers[idx] = newValue
        }
    }
}
