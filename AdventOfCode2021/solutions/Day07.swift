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
        let median = Int(calculateMedian(array: horizontalPositions))

        return horizontalPositions
            .map { abs($0 - median) }
            .reduce(0, +)
    }

    func part2() -> Int {
        let horizontalPositions = parsePositions()
        var minFuel = Int.max

        meanValues(array: horizontalPositions)
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

    private func calculateMedian(array: [Int]) -> Double {
        let sorted = array.sorted()
        let count = array.count
        if sorted.count % 2 == 0 {
            return Double((sorted[(count / 2)] + sorted[(count / 2) - 1])) / 2
        }
        return Double(sorted[(count - 1) / 2])
    }

    private func meanValues(array: [Int]) -> Set<Int> {
        let sum = array.reduce(0, +)

        let means = [
            (Double(sum) / Double(array.count)).rounded(.down),
            (Double(sum) / Double(array.count)).rounded(.up),
        ].map(Int.init)
        return Set(means)
    }
}
