//
//  main.swift
//  Assembler
//
//  Created by Murat Dogu on 28.10.2017.
//  Copyright © 2017 Murat Dogu. All rights reserved.
//

import Foundation

guard CommandLine.argc == 2 else {
    Console.error("Usage: Assembler filename.asm")
    exit(0)
}

do {
    let parser = try Parser(inputFile: CommandLine.arguments[1])
} catch {
    print(error)
}


//let fileName = CommandLine.arguments[1].replacingOccurrences(of: ".asm", with: "")
//let currentFolder = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
//let fileURL = currentFolder.appendingPathComponent(fileName).appendingPathExtension("hack")
//
//do {
//    try "Test".write(to: fileURL, atomically: true, encoding: .utf8)
//    Console.print("Binary file is created successfully.")
//} catch {
//    print(error)
//}

