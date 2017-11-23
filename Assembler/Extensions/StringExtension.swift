//
//  StringExtension.swift
//  Assembler
//
//  Created by Murat Dogu on 23.11.2017.
//  Copyright © 2017 Murat Dogu. All rights reserved.
//

import Foundation

extension String {
    
    func ends(with suffix: String) -> Bool {
        guard count > suffix.count else { return false }
        let index = self.index(endIndex, offsetBy: -suffix.count)
        let end = self[index...]
        return end == suffix
    }
    
}
