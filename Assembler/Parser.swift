//
//  Parser.swift
//  Assembler
//
//  Created by Murat Dogu on 29.10.2017.
//  Copyright © 2017 Murat Dogu. All rights reserved.
//

import Foundation

class Parser {
    
    let contents: String
    let lines: [String]
    var instructions: [Instruction]?
    
    init(inputFile: String) throws {
        let currentFolder = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let fileURL = currentFolder.appendingPathComponent(inputFile)
        contents = try String(contentsOf: fileURL)
        lines = contents.components(separatedBy: .newlines)
    }
    
    func getLabels() {
        for line in lines {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            
        }
    }
    
}

enum CommandType {
    case typeA(address: String)
    case typeC(dest: String?, comp: String, jump: String?)
    case label(String)
}

struct Instruction {
    let lineNumber: Int
    let type: CommandType!
}

