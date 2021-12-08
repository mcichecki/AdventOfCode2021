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

    enum Digit: Int, CaseIterable {
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

    /// Implementation of this approach:
    /// https://www.reddit.com/r/adventofcode/comments/rbvpui/2021_day_8_part_2_my_logic_on_paper_i_used_python/
    func part2() -> Int {
        let signals = parseInput()

        var numbers: [Int] = []

        signals.forEach { signal in
            let digitPatterns = getDigitPatterns(signal: signal)

            var numbersString = ""
            signal.output
                .forEach { output in
                    numbersString.append(
                        contentsOf: String(digitPatterns.swapped()[Set(output)]!.rawValue)
                    )
                }
            numbers.append(Int(numbersString)!)
        }
        return numbers.reduce(0, +)
    }
}

extension Day08 {
    fileprivate func getDigitPatterns(signal: Signal) -> [Digit: Set<Character>] {
        let knownDigits: [Digit] = [.one, .four, .seven, .eight]
        var digitPatterns: [Digit: Set<Character>] = [:]

        signal.signalPatterns
            .forEach { pattern in
                knownDigits.forEach { digit in
                    if digit.lettersCount == pattern.count {
                        digitPatterns[digit] = Set(pattern)
                    }
                }
            }

        let fourCharacters = digitPatterns[.four]!.subtracting(digitPatterns[.one]!)
        let oneCharacters = digitPatterns[.one]!

        signal.signalPatterns
            .filter { $0.count == Digit.five.lettersCount }
            .forEach { pattern in
                let digit: Digit
                if oneCharacters.isSubset(of: Set(pattern)) {
                    digit = .three
                } else if fourCharacters.isSubset(of: Set(pattern)) {
                    digit = .five
                } else {
                    digit = .two
                }
                digitPatterns[digit] = Set(pattern)
            }

        signal.signalPatterns
            .filter { $0.count == Digit.six.lettersCount }
            .forEach { pattern in
                let digit: Digit
                if fourCharacters.isSubset(of: Set(pattern)) && oneCharacters.isSubset(of: Set(pattern)) {
                    digit = .nine
                } else if fourCharacters.isSubset(of: Set(pattern)) {
                    digit = .six
                } else {
                    digit = .zero
                }
                digitPatterns[digit] = Set(pattern)
            }

        return digitPatterns
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
    var lettersCount: Int {
        switch self {
        case .zero, .six, .nine:
            return 6
        case .one:
            return 2
        case .two, .three, .five:
            return 5
        case .four:
            return 4
        case .seven:
            return 3
        case .eight:
            return 7
        }
    }
}

extension Dictionary where Value: Hashable {
    fileprivate func swapped() -> [Value: Key] {
        var newDict: [Value: Key] = [:]
        self.forEach {
            newDict[$0.value] = $0.key
        }
        return newDict
    }
}
