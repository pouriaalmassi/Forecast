//
//  Throttler.swift
//  Forecast
//
//  Created by Pouria Almassi on 6/12/20.
//

import Foundation

// Credit: https://www.craftappco.com/blog/2018/5/30/simple-throttling-in-swift
final class Throttler {
    private var workItem = DispatchWorkItem(block: {})
    private var previousRun = Date.distantPast
    private let queue = DispatchQueue.main
    private let minimumDelay: TimeInterval

    init(minimumDelay: TimeInterval) {
        self.minimumDelay = minimumDelay
    }

    func throttle(_ block: VoidCallback?) {
        // Cancel any existing work item if it has not yet executed.
        workItem.cancel()

        // Re-assign workItem with the new block task, resetting the previousRun time when it executes.
        workItem = DispatchWorkItem() { [weak self] in
            self?.previousRun = Date()
            block?()
        }

        // If the time since the previous run is more than the required minimum delay
        // => execute the workItem immediately
        // else
        // => delay the workItem execution by the minimum delay time
        let delay = previousRun.timeIntervalSinceNow > minimumDelay ? 0 : minimumDelay
        queue.asyncAfter(deadline: .now() + Double(delay), execute: workItem)
    }
}
