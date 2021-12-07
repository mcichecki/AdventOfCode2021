//
//  Day07.swift
//  AdventOfCode2021
//
//  Created by Michal Cichecki on 07/12/2021.
//

import Foundation

struct Day07: Day {
    let dayNumber = 7

    private let input = InputReader.read(fileName: "day07")

    func part1() -> Int {
        let horizontalPositions = parsePositions()
        var minFuel = Int.max

        Set(horizontalPositions)
            .forEach { checkedPosition in
                let result = horizontalPositions
                    .map { abs($0 - checkedPosition) }
                    .reduce(0, +)

                if result < minFuel {
                    minFuel = result
                }
            }

        return minFuel
    }

    func part2() -> Int {
        .min
    }
}

extension Day07 {
    private func parsePositions() -> [Int] {
        guard input.count == 1 else { return [] }
        return input.first?.asInts(separatedBy: ",") ?? []
    }
}
