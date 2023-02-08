//
//  TimerManager.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/08.
//

import Foundation

final class TimerManager {
    private var timer: Timer?
    private var timeInterval: TimeInterval = 1.0 /// time간격 기본 1초
    private var finishTime: TimeInterval = 0.0 /// finishTime
    ///
    private var tickAction: (() -> Void)? /// 매초마다 호출되는 액션
    private var finishAction: (() -> Void)? /// timer종료시 호출되는 액션

    init(
        timeInterval: TimeInterval = 1.0,
        finishTime: TimeInterval = 0.0
    ) {
        self.timeInterval = timeInterval
        self.finishTime = finishTime
    }

    func startTimer(
        tickAction: (() -> Void)? = nil,
        finishAction: (() -> Void)? = nil
    ) {
        guard timeInterval != 0.0 else {
            return
        }
        self.tickAction = tickAction
        self.finishAction = finishAction

        timer = Timer.scheduledTimer(
            timeInterval: timeInterval,
            target: self,
            selector: #selector(tick),
            userInfo: nil,
            repeats: true)
    }

    /// restart
    func restartTimer(tickAction: @escaping (() -> Void)) {
        stopTimer()
        startTimer(tickAction: tickAction)
    }

    /// stop
    func stopTimer() {
        if self.timer == nil {
            return
        }
        timer?.invalidate()
        timer = nil
        self.finishAction?()
    }

    @objc private func tick() {
        self.tickAction?()
        self.finishTime -= self.timeInterval

        if finishAction != nil {
            if finishTime <= 0.0 {
                self.stopTimer()
            }
        }
    }
}
