//
//  FileHandleExtensions.swift
//  Assembler
//
//  Created by Murat Doğu on 22.11.2017.
//  Copyright © 2017 Murat Dogu. All rights reserved.
//

import Foundation

extension FileHandle {
    
    func readLine() -> String? {
        let line: String?
        let delimeterData = "\n".data(using: .utf8)!
        while true {
            let buffer = readData(ofLength: 4096)
            if let range = buffer.range(of: delimeterData) {
                
            } else {
                if buffer.count > 0 {
                    
                } else {
                    break
                }
            }
        }
        
        return line
    }
    
}
