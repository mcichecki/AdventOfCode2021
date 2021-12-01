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

        let solution = increasesCount(depths)
        printSolution(part: .one, solution: solution)
    }

    func part2() {
        let depths = InputReader.read(fileName: "day01_1")
            .compactMap { Int($0) }

        let windowSize = 3
        var windows = Array(repeating: 0, count: depths.count - 2)

        for (index, depth) in depths.enumerated() {
            let indexes: Range<Int> = {
                // start
                if index < windowSize {
                    return max(0, index - 2) ..< index + 1
                }
                // end
                if index >= windows.count {
                    return index - 2 ..< min(index, windows.count)
                }
                return index - 2 ..< index + windowSize - 2
            }()
            indexes.forEach { windows[$0] += depth }
        }

        let solution = increasesCount(windows)
        printSolution(part: .two, solution: solution)
    }
}

extension Day01 {
    private func increasesCount(_ arr: [Int]) -> Int {
        zip(arr.dropFirst(), arr)
            .map(-)
            .filter { $0 > 0 }
            .count
    }
}
