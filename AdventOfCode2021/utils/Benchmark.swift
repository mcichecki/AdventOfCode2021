//
//  Benchmark.swift
//  AdventOfCode2021
//
//  Created by Michal Cichecki on 01/12/2021.
//

import Foundation

struct Benchmark {
    static func execute(
        part: Part,
        _ solution: () -> Any
    ) {
        let start = DispatchTime.now()
        let answer = solution()
        let duration = start.distance(to: .now())
        print("|- Part #\(part.rawValue) answer: \(answer) [\(duration.msDescription)]")
    }
}

// MARK: - DispatchTimeInterval+milliseconds

extension DispatchTimeInterval {
    fileprivate var ms: Double {
        switch self {
        case .seconds(let s):
            return Double(s) * 1_000.0
        case .milliseconds(let ms):
            return Double(ms)
        case .microseconds(let us):
            return Double(us) / 1_000 // rounds toward zero
        case .nanoseconds(let ns):
            return Double(ns) / 1_000_000 // rounds toward zero
        case .never:
            return .infinity
        @unknown default:
            return .zero
        }
    }
    
    fileprivate var msDescription: String {
        String("\(Double(round(100 * ms) / 100)) ms")
    }
}
