//
//  ValueAnimator.swift
//  HobbyRandomizer
//
//  Created by Apple Mac Book on 16.10.2021.
//

import UIKit

/**
 https://stackoverflow.com/questions/61594608/ios-equivalent-of-androids-valueanimator
 */

// swiftlint:disable:next private_over_fileprivate
fileprivate var defaultFunction: (TimeInterval, TimeInterval) -> (Double) = { time, duration in
  return time / duration
}

protocol ValueAnimatorDelegate {
    func onUpdate(value: Double) -> Void
    func onStop() -> Void
}

/**
 //        let valueAnimator = ValueAnimator(from: 0, to: 100, duration: 1, animationCurveFunction: { time, duration in
 //          return atan(time)*2/Double.pi
 //        }, valueUpdater: { value in
 //          print("value: \(value)")
 //        })
 */
class ValueAnimator {

      let from: Double
      let to: Double
      var duration: TimeInterval = 0
      var startTime: Date!
      var displayLink: CADisplayLink?
      var animationCurveFunction: (TimeInterval, TimeInterval) -> (Double)
      var valueUpdater: (Double) -> Void
      var onStop: () -> Void

      init (from: Double = 0, to: Double = 1, duration: TimeInterval, animationCurveFunction: @escaping (TimeInterval, TimeInterval) -> (Double) = defaultFunction, valueUpdater: @escaping (Double) -> Void,
            onStop: @escaping () -> Void) {
        self.onStop = onStop
        self.from = from
        self.to = to
        self.duration = duration
        self.animationCurveFunction = animationCurveFunction
        self.valueUpdater = valueUpdater
      }

      func start() {
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .current, forMode: .default)
      }

      @objc
      private func update() {

        if startTime == nil {
          startTime = Date()
          valueUpdater(from + (to - from) * animationCurveFunction(0, duration))
          return
        }

        var timeElapsed = Date().timeIntervalSince(startTime)
        var stop = false

        if timeElapsed > duration {
          timeElapsed = duration
          stop = true
        }

        valueUpdater(from + (to - from) * animationCurveFunction(timeElapsed, duration))

        if stop {
          onStop()
          cancel()
        }
      }

      func cancel() {
        self.displayLink?.remove(from: .current, forMode: .default)
        self.displayLink = nil
      }
}
