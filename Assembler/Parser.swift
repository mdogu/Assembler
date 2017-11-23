//
//  Parser.swift
//  Assembler
//
//  Created by Murat Dogu on 29.10.2017.
//  Copyright © 2017 Murat Dogu. All rights reserved.
//

import Foundation

class Parser {
    
    var instructions: [Command]?
    
    let inputFile: FileHandle
    let outputFile: FileHandle
    
    init(inputFile: String) throws {
        let currentFolder = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let inputURL = currentFolder.appendingPathComponent(inputFile)
        let outputFile = inputFile.replacingOccurrences(of: ".asm", with: ".hack")
        let outputURL = currentFolder.appendingPathComponent(outputFile)
        
        self.inputFile = try FileHandle(forReadingFrom: inputURL)
        
        if FileManager.default.fileExists(atPath: outputURL.path) == false {
            FileManager.default.createFile(atPath: outputURL.path, contents: nil, attributes: nil)
        }
        self.outputFile = try FileHandle(forUpdating: outputURL)
    }
    
    func execute() {
        while let line = inputFile.readLine() {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            guard trimmed.count > 0, trimmed.starts(with: "//") == false else { continue }
            
            if trimmed.starts(with: "@") {
                outputFile.write(instruction: "A-instruction")
            } else if trimmed.contains("=") || trimmed.contains(";") {
                outputFile.write(instruction: "C-instruction")
            } else if trimmed.starts(with: "("){
                outputFile.write(instruction: "Label")
            }
        }
        inputFile.closeFile()
        outputFile.closeFile()
    }
    
    func getLabels() {
        
    }
    
}

enum Command {
    case typeA(address: String)
    case typeC(dest: String?, comp: String, jump: String?)
    case label(String)
}

