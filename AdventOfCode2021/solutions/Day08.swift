//
//  Day08.swift
//  AdventOfCode2021
//
//  Created by Michal Cichecki on 08/12/2021.
//

import Foundation

struct Day08: Day {
    let dayNumber = 8

    struct Signal {
        var signalPatterns: [String]
        var output: [String]
    }

    enum Digit {
        case zero
        case one
        case two
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
    }

    private let input = InputReader.read(fileName: "day08")

    func part1() -> Int {
        let signals = parseInput()
        let digits: [Digit] = [.one, .four, .seven, .eight]
        
        return signals.reduce(0) { partialResult, signal in
            var count = 0
            digits.forEach {
                for output in signal.output where output.count == $0.lettersCount {
                    count += 1
                }
            }
            return partialResult + count
        }
    }

    func part2() -> Int {
        .min
    }
}

extension Day08 {
    private func parseInput() -> [Signal] {
        input.compactMap {
            let parts = $0.components(separatedBy: " | ")
            guard parts.count == 2 else { return nil }
            let rawSignalPatterns = parts[0].components(separatedBy: " ")
            let rawOutput = parts[1].components(separatedBy: " ")

            return Signal(signalPatterns: rawSignalPatterns, output: rawOutput)
        }
    }
}

extension Day08.Digit {
    var letters: [Character] {
        switch self {
        case .zero:
            return ["a", "b", "c", "e", "f", "g"]
        case .one:
            return ["c", "f"]
        case .two:
            return []
        case .three:
            return []
        case .four:
            return ["b", "c", "d", "f"]
        case .five:
            return []
        case .six:
            return []
        case .seven:
            return ["a", "c", "f"]
        case .eight:
            return ["a", "b", "c", "d", "e", "f", "g"]
        case .nine:
            return []
        }
    }

    var lettersCount: Int {
        letters.count
    }
}
