//
//  ThirdViewController.swift
//  GCD
//
//  Created by Игорь Девин on 25.03.2024.
//

import UIKit


//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//            super.viewDidLoad()
//
//        print(1)
//        Task {
//            print(2)
//        }
//        print(3)
//    }
//}
//
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//            super.viewDidLoad()
//
//        print(1)
//        Task { @MainActor  in
//            print(2)
//            DispatchQueue.global().sync {
//                self.print4()
//                print(Thread.current)
//            }
//        }
//        print(3)
//    }
//    func print4() {
//        print("4")
//    }
//}
//
//class ViewController: UIViewController {
//
//
//    override func viewDidLoad() {
//            super.viewDidLoad()
//
//        print("Task 1 is finished")
//
//        Task.detached(priority: .userInitiated) {
//            print(Thread.current)
//            for i in 0..<50 {
//                print(i)
//            }
//            print("Task 2 is finished")
//            DispatchQueue.main.sync {
//                print(Thread.current)
//            }
//        }
//
//        print("Task 3 is finished")
//    }
//}
//
//class ViewController: UIViewController {
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//
//        Task {
//            let result =  await randomD6()
//            print(result)
//        }
//        func randomD6() async -> Int {
//            Int.random(in: 1...6)
//        }
//    }
//}
//
//class ViewController: UIViewController {
//
//
//    var networkService = NetworkService()
//
//    override func viewDidLoad() {
//            super.viewDidLoad()
//
//        Task {
//            await fetchResult()
//        }
//    }
//
//    func fetchMessagesResult(completion: @escaping ([Message]) -> Void) {
//        networkService.fetchMessages { message in
//            completion(message)
//        }
//    }
//    func fetchResult() async -> [Message] {
//        return await withCheckedContinuation { result in
//            networkService.fetchMessages { messages in
//                result.resume(returning: messages)
//                print(messages)
//            }
//        }
//    }
//    func fetchResultSecure() async throws -> [Message] {
//        try await withCheckedThrowingContinuation { result in
//           networkService.fetchMessages { messages in
//               if messages.isEmpty {
//                   result.resume(throwing: Error.self as! Error)
//               } else {
//                   result.resume(returning: messages)
//               }
//                result.resume(returning: messages)
//                print(messages)
//            }
//        }
//    }
//}
//
//struct Message: Decodable, Identifiable {
//    let id: Int
//    let from: String
//    let message: String
//}
//
//
//class NetworkService {
//
//    func fetchMessages(completion: @escaping ([Message]) -> Void) {
//        let url = URL(string: "https://hws.dev/user-messages.json")!
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                if let messages = try? JSONDecoder().decode([Message].self, from: data) {
//                    completion(messages)
//                    return
//                }
//            }
//
//            completion([])
//        }
//        .resume()
//    }
//}
//
//class ViewController: UIViewController {
//
//
//    override func viewDidLoad() {
//            super.viewDidLoad()
//
//        Task {
//            await getAverageTemperature()
//        }
//    }
//
//    func getAverageTemperature() async {
//        let fetchTask = Task { () -> Double in
//            let url = URL(string: "https://hws.dev/readings.json")!
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let readings = try JSONDecoder().decode([Double].self, from: data)
//            let sum = readings.reduce(0, +)
//            return sum / Double(readings.count)
//        }
//
//       // Тут отмените задачу
//            fetchTask.cancel()
//        do {
//            let result = try await fetchTask.value
//            print("Average temperature: \(result)")
//        } catch {
//            print("Failed to get data.")
//        }
//    }
//}
//
//class ViewController: UIViewController {
//
//
//    override func viewDidLoad() {
//            super.viewDidLoad()
//
//        Task {
//            await printMessage()
//        }
//    }
//
//    func printMessage() async {
//        let string = await withTaskGroup(of: String.self) { group -> String in
//           // тут добавляем строки в группу
//            group.addTask {
//                ("Vaka - SENIOR")
//            }
//            group.addTask {
//                ("Vaka - IIIaIIIJIbIK")
//            }
//            group.addTask {
//                ("EUGEN")
//            }
//            var collected = [String]()
//
//            for await value in group {
//                collected.append(value)
//            }
//
//            return collected.joined(separator: " ")
//        }
//
//        print(string)
//    }
//}
//

