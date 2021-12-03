//
//  Day03.swift
//  AdventOfCode2021
//
//  Created by Michal Cichecki on 03/12/2021.
//

import Foundation

struct Day03: Day {
    let dayNumber = 3
    let diagnosticReport = InputReader.read(fileName: "day03")

    func part1() -> Any {
        var gammaRate = 0
        var epsilon = 0
        var occurances: [Int: Int] = [:]
        var binaryCount = 0

        diagnosticReport
            .forEach {
                binaryCount = $0.count
                $0.enumerated().forEach { index, char in
                    if char == "1" {
                        occurances[index, default: 0] += 1
                    }
                }
            }

        var gammaArray = Array(repeating: "0", count: binaryCount)
        var epsilonArray = Array(repeating: "1", count: binaryCount)
        occurances
            .filter { $0.value > diagnosticReport.count / 2 }
            .forEach {
                gammaArray[$0.key] = "1"
                epsilonArray[$0.key] = "0"
            }

        gammaRate = Int(gammaArray.joined(separator: ""), radix: 2)!
        epsilon = Int(epsilonArray.joined(separator: ""), radix: 2)!
        return gammaRate * epsilon
    }

    func part2() -> Any {
        ""
    }
}
