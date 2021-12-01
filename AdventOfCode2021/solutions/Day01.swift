//
//  01.swift
//  AdventOfCode2021
//
//  Created by Michal Cichecki on 30/11/2021.
//

import Foundation

struct Day01: Day {
    let dayNumber = 1

    func part1() {
        let depths = InputReader.read(fileName: "day01_1")
            .compactMap { Int($0) }

        let increases = zip(depths.dropFirst(), depths)
            .map(-)
            .filter { $0 > 0 }
            .count

        printSolution(part: .one, solution: increases)
    }

    func part2() {
        let depths = InputReader.read(fileName: "day01_1")
            .compactMap { Int($0) }

        let windowSize = 3
        let depthsCount = depths.count
        let increases = (0 ... depths.count)
            .filter { $0 <= depthsCount - (windowSize + 1) }
            .map {
                let current = depths[$0 ..< $0 + windowSize].reduce(0, +)
                let next = depths[$0 + 1 ..< $0 + windowSize + 1].reduce(0, +)
                return next - current
            }
            .filter { $0 > 0 }
            .count

        printSolution(part: .two, solution: increases)
    }
}
