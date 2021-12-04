//
//  Day04.swift
//  AdventOfCode2021
//
//  Created by Michal Cichecki on 04/12/2021.
//

import Foundation

struct Day04: Day {
    final class BingoBoard {
        var rows: [[(value: Int, isMarked: Bool)]]
        var completed: Bool = false

        init(rows: [[(Int, Bool)]]) {
            self.rows = rows
        }
    }

    let dayNumber = 4
    let input = InputReader.read(fileName: "day04")

    func part1() -> Any {
        let answers: [Int] = input[0].asInts(separatedBy: ",")
        let boards = parseBoards(answers: Array(input.dropFirst()))

        for answer in answers {
            for board in boards {
                guard let ans = board.checkMatch(answer: answer) else { continue }
                return ans.0 * board.sumOfMarkedNumbers
            }
        }

        assertionFailure("Didn't find a solution")
        return Int.max
    }

    func part2() -> Any {
        let answers: [Int] = input[0].asInts(separatedBy: ",")
        let boards = parseBoards(answers: Array(input.dropFirst()))

        var completedBingosCount = 0
        for answer in answers {
            for board in boards where !board.completed {
                if let ans = board.checkMatch(answer: answer) {
                    if completedBingosCount + 1 == boards.count {
                        return ans.0 * board.sumOfMarkedNumbers
                    }
                    board.completed = true
                    completedBingosCount += 1
                }
            }
        }

        return ""
    }
}

extension Day04 {
    private func parseBoards(answers: [String]) -> [BingoBoard] {
        answers
            .chunked(into: 5)
            .map {
                var rows: [[Int]] = []
                $0.forEach { row in rows.append(row.asInts(separatedBy: " ")) }
                return BingoBoard(rows: rows.map { $0.map { ($0, false) }})
            }
    }
}

extension Day04.BingoBoard {
    func column(at index: Int) -> [(Int, Bool)] {
        var column: [(Int, Bool)] = []
        for row in rows {
            column.append(row[index])
        }
        return column
    }

    fileprivate var sumOfMarkedNumbers: Int {
        var sum = 0
        for row in rows {
            for column in row where !column.isMarked {
                sum += column.value
            }
        }

        return sum
    }

    fileprivate func checkMatch(answer: Int) -> (number: Int, row: [(Int, Bool)])? {
        guard let (row, column) = findPosition(number: answer) else { return nil }
        rows[row][column].isMarked = true
        guard let row = checkWinningNumbers() else { return nil }
        return (answer, row)
    }

    private func findPosition(number: Int) -> (row: Int, column: Int)? {
        for (rowIndex, rowValue) in rows.enumerated() {
            for (columnIndex, columnValue) in rowValue.enumerated() where columnValue.value == number {
                return (rowIndex, columnIndex)
            }
        }

        return nil
    }

    private func checkWinningNumbers() -> [(Int, Bool)]? {
        for (rowIndex, rowValue) in rows.enumerated() {
            // row check
            if !rowValue.contains(where: { !$0.isMarked }) {
                return rows[rowIndex]
            }
            // columns check
            let markedColumns = column(at: rowIndex)
            if !markedColumns.contains(where: { !$0.1 }) {
                return column(at: rowIndex)
            }
        }

        return nil
    }
}

extension Array {
    fileprivate func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}


extension String {
    fileprivate func asInts(separatedBy separator: String) -> [Int] {
        components(separatedBy: separator)
            .compactMap(Int.init)
    }
}
