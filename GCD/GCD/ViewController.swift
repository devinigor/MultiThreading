//
//  ViewController.swift
//  GCD
//
//  Created by Игорь Девин on 20.03.2024.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
        Thread.detachNewThread {
            for _ in (0..<10) {
                let currentThread = Thread.current
                print("1, Current thread: \(currentThread)")
            }
        }
      for _ in (0..<10) {
         let currentThread = Thread.current
         print("2, Current thread: \(currentThread)")
      }
    }
}


class TaskViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Создаем и запускаем поток с таймером
        let timer = TimerThread(duration: 10)
        timer.start()
        print(Thread.current)
    }
    
    class TimerThread: Thread {
        private var timerDuration: Int
        private var timer: Timer!
        
        init(duration: Int) {
            self.timerDuration = duration
        }
        
        override func main() {
            // Создаем таймер, который будет выполняться каждую секунду
                timer = Timer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
                timer.invalidate()
                print(Thread.current)
                
                
                // Добавляем таймер в текущий run loop ниже
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    self.updateTimer()
                }
                
                // Запускаем текущий run loop ниже
                RunLoop.current.run()
        }
        
        @objc func updateTimer() {
            // Ваш код здесь будет выполняться каждую секунду
            if timerDuration > 0 {
                print("Осталось \(timerDuration) секунд...")
                timerDuration -= 1
            } else {
                print("Время истекло!")
                
                timer.invalidate()
                // Остановка текущего run loop после завершения таймера
                while !isCancelled {
                CFRunLoopStop(CFRunLoopGetCurrent())
                    RunLoop.current.run(until: Date() + 1)
                }
            }
        }
    }
}



