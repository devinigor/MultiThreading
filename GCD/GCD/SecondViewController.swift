//
//  SecondViewController.swift
//  GCD
//
//  Created by Игорь Девин on 20.03.2024.
//

import UIKit

final class TaskTwoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Создаем и запускаем поток
        let infinityThread = InfinityLoop()
        infinityThread.start()
        print(infinityThread.isExecuting)
        /// Подождем некоторое время, а затем отменяем выполнение потока
        sleep(2)
        print(infinityThread.isCancelled)
        /// Отменяем тут
        infinityThread.cancel()
        print(infinityThread.isFinished)
    }
    
    class InfinityLoop: Thread {
        var counter = 0
        
        override func main() {
            while counter < 30 && !isCancelled {
                Timer.scheduledTimer(withTimeInterval: 0, repeats: true) { _ in
                    self.counter += 1
                    print(self.counter)
                    InfinityLoop.sleep(forTimeInterval: 1)
                }
                RunLoop.current.run(until: Date() + 5)
            }
        }
    }
}


///Наберите весь код руками. 1) Выставить правильные приоритеты, чтобы сначала печатали 1, потом 2. 2) Изменить приоритеты: 2 потом 1. 3) Поменять приоритет, чтобы печаталось вперемешку

final class TaskTwoPointTwoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Создаем и запускаем поток
        let thread1 = ThreadprintDemon()
        let thread2 = ThreadprintAngel()
        
        /// Меняем приоритеты
        /// Печатает 2 потом 1
//        thread1.qualityOfService = .background
//        thread2.qualityOfService = .userInitiated
        ///Печатает 1 потом 2
        thread1.qualityOfService = .userInteractive
        thread2.qualityOfService = .background
        
        /// Вперемешку
        thread1.qualityOfService = .default
        thread2.qualityOfService = .default
        
        thread1.start()
        thread2.start()
        
    }
    
    class ThreadprintDemon: Thread {
        override func main() {
            for _ in (0..<100) {
                print("1")
            }
        }
    }
    class ThreadprintAngel: Thread {
        override func main() {
            for _ in (0..<100) {
                print("2")
            }
        }
    }
}

final class TaskTwoPointFourViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("A")
        DispatchQueue.main.async {
            print("B")
        }
        print("C")
    }
    
    /// A, C, B потому что сначало распечатается все что на главном потоке в оновной очереди а потом то что стоит в очереди
}

final class TaskThreePointThreeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print(2)
        DispatchQueue.main.async {
            print(3)
            DispatchQueue.main.sync {
                print(5)
            }
            print(4)
        }
        print(6)
    }
}

final class TaskTwoPointThreeViewController: UIViewController {
    
    private let lockQueue = DispatchQueue(label: "queue")
    private var name = "Введите имя"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateName()
    }
    
    func updateName() {
        DispatchQueue.global().async {
            self.lockQueue.async {
                self.name = "I love RM" /// Перезаписываем имя в другом потоке
                print(Thread.current)
                print(self.name)
            }
        }
        
        lockQueue.async {
            print(self.name) /// Считываем имя из main
        }
    }
}

final class TaskTwoPointSixViewController: UIViewController {
    private lazy var name = "I love RM"
    let nsLock = NSLock()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateName()
    }
    
    func updateName() {
        DispatchQueue.global().async {
            self.nsLock.lock()
            print(self.name) /// Считываем имя из global
            print(Thread.current)
            do {
                self.nsLock.unlock()
            }
        }
        nsLock.lock()
        print(self.name) /// Считываем имя из main
        nsLock.unlock()
    }
}
