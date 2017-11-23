//
//  main.swift
//  Assembler
//
//  Created by Murat Dogu on 28.10.2017.
//  Copyright © 2017 Murat Dogu. All rights reserved.
//

import Foundation

guard CommandLine.argc == 2, CommandLine.arguments[1].ends(with: ".asm") else {
    Console.error("Usage: Assembler filename.asm")
    exit(0)
}

let parser: Parser
do {
    parser = try Parser(inputFile: CommandLine.arguments[1])
} catch {
    print(error.localizedDescription)
    exit(0)
}
parser.execute()

