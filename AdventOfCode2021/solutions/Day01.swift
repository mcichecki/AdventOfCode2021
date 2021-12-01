//
//  01.swift
//  AdventOfCode2021
//
//  Created by Michal Cichecki on 30/11/2021.
//

import Foundation

struct Day01: Day {
    static let dayNumber = 1

    static func part1() {
        let depths = InputReader.read(fileName: "day01_1")
            .compactMap { Int($0) }

        let solution = zip(depths.dropFirst(), depths)
            .map(-)
            .filter { $0 > 0 }
            .count

        Self.printSolution(part: .one, solution: solution)
    }
}
