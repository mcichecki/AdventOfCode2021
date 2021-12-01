//
//  InputReader.swift
//  AdventOfCode2021
//
//  Created by Michal Cichecki on 29/11/2021.
//

import Foundation

enum InputReader {
    static func read(
        fileName: String,
        extensionName: String = "txt",
        removeEmptyLines: Bool = true
    ) -> [String] {
        guard let fileURL = Bundle.main.path(forResource: fileName, ofType: "txt") else {
            fatalError("Pathname not found for file: \(fileName).\(extensionName)")
        }

        do {
            let content = try String(contentsOfFile: fileURL, encoding: .utf8)
            let lines = content.components(separatedBy: .newlines)
            if removeEmptyLines {
                return lines.filter { !$0.isEmpty }
            }
            return lines
        } catch {
            print("Error reading contents of file: \(error)")
            return []
        }
    }
}
