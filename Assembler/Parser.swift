//
//  Parser.swift
//  Assembler
//
//  Created by Murat Dogu on 29.10.2017.
//  Copyright © 2017 Murat Dogu. All rights reserved.
//

import Foundation

class Parser {
    
    var instructions = [Instruction]()
    
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
        firstPass()
        secondPass()
        closeFiles()
    }
    
    func firstPass() {
        while let line = inputFile.readLine() {
            let trimmed = line.trimmingCharacters(in: .whitespaces)
            guard trimmed.count > 0, trimmed.starts(with: "//") == false else { continue }
            
            if trimmed.starts(with: "@") {
                // A-instruction
                guard let value = trimmed.trimmingFirstCharacter() else { continue }
                let instruction: Instruction = .typeA(address: value)
                instructions.append(instruction)
            } else if trimmed.contains("=") || trimmed.contains(";") {
                // C-instruction
                let set = CharacterSet(charactersIn: "=;")
                let parts = trimmed.components(separatedBy: set)
                let instruction: Instruction
                if trimmed.contains("=") && trimmed.contains(";") {
                    guard parts.count == 3 else { continue }
                    instruction = .typeC(dest: parts[0], comp: parts[1], jump: parts[2])
                } else if trimmed.contains("=") {
                    guard parts.count == 2 else { continue }
                    instruction = .typeC(dest: parts[0], comp: parts[1], jump: nil)
                } else if trimmed.contains(";") {
                    guard parts.count == 2 else { continue }
                    instruction = .typeC(dest: nil, comp: parts[0], jump: parts[1])
                } else {
                    continue
                }
                instructions.append(instruction)
            } else if trimmed.starts(with: "(") && trimmed.ends(with: ")") {
                // Label
                let parantheses = CharacterSet(charactersIn: "()")
                let label = trimmed.trimmingCharacters(in: parantheses)
                guard label.count > 0 else { continue }
                Symbol.table[label] = instructions.count
            }
        }
    }
    
    func secondPass() {
        for instruction in instructions {
            switch instruction {
            case .typeA(address: let value):
                let location: Int
                if let address = Int(value), address > 0 {
                    location = address
                } else {
                    if let address = Symbol.table[value] {
                        location = address
                    } else {
                        location = Symbol.nextAvailableRAMLocation
                        Symbol.table[value] = Symbol.nextAvailableRAMLocation
                        Symbol.nextAvailableRAMLocation += 1
                    }
                }
                let binary = String(location, radix: 2, length: 15)
                outputFile.write(line: "0" + binary)
            case .typeC(dest: let dest, comp: let comp, jump: let jump):
                let destBinary = Code.dest(input: dest)
                let compBinary = Code.comp(input: comp)
                let jumpBinary = Code.jump(input: jump)
                outputFile.write(line: "111" + compBinary + destBinary + jumpBinary)
            }
        }
    }
    
    func closeFiles() {
        inputFile.closeFile()
        outputFile.closeFile()
    }
    
}

enum Instruction {
    case typeA(address: String)
    case typeC(dest: String?, comp: String, jump: String?)
}

