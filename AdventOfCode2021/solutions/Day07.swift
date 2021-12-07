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

    // Runs in ~400ms with the optimizations enabled
    func part2() -> Int {
        let horizontalPositions = parsePositions()
        var minFuel = Int.max

        (0 ... horizontalPositions.max()!)
            .forEach { checkedPosition in
                let result = horizontalPositions
                    .filter { $0 != checkedPosition }
                    .map {
                        let res = abs($0 - checkedPosition)
                        return (1 ... res).reduce(0, +)
                    }
                    .reduce(0, +)

                if result < minFuel {
                    minFuel = result
                }
            }

        return minFuel
    }
}

extension Day07 {
    private func parsePositions() -> [Int] {
        guard input.count == 1 else { return [] }
        return input.first?.asInts(separatedBy: ",") ?? []
    }
}
