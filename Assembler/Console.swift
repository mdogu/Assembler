//
//  Console.swift
//  Assembler
//
//  Created by Murat Dogu on 29.10.2017.
//  Copyright © 2017 Murat Dogu. All rights reserved.
//

import Foundation

class Console {
    
    static func print(_ message: String) {
        print(message)
    }
    
    static func error(_ message: String) {
        fputs("\u{001B}[0;31m\(message)\u{001B}[;m\n", stderr)
    }
    
}
