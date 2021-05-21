//
//  AppDelegate.swift
//  DadFoundation
//
//  Created by NGUYEN CHI CONG on 05/14/2021.
//  Copyright (c) 2021 NGUYEN CHI CONG. All rights reserved.
//

import Boardy
import DadFoundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

enum SomeID {
    case some1
    case some2
}

protocol SomeExProducer {
    func produce(identifier: SomeID) -> ActivatableBoard
}

struct SomeModuleLoader: ModuleLoader {
    var identifier: String { id.rawValue }

    let id: BoardID
    var exProducer: SomeExProducer
    var exDepsFac: () -> Any

    func load(in container: ModuleContainer) {
        container.registerBoard({ (identifier) -> ActivatableBoard in
            print("\(identifier)")
            fatalError()
        }, with: id)
    }
}

final class ApplicationComponent: MainComponent {
    var producer: ActivableBoardProducer { container }

    var modules: [ModuleLoader] = []

    func append(module: ModuleLoader) {
        if !modules.contains(where: { $0.identifier == module.identifier }) {
            modules.append(module)
        } else {
            print("⚠️ Duplicated module \(module.identifier)")
        }
    }

    var container = BoardContainer()

    func registerBoard(_ factory: @escaping (BoardID) -> ActivatableBoard, with identifier: BoardID) {
        print("App Reg OK")
    }

    private func load() {
        modules.forEach { $0.load(in: self) }
    }

    private func initRoot() {}

    private func activateRoot() {}

    func launch() {
        load()
        initRoot()
        activateRoot()
    }
}

protocol MainComponent: ModuleContainer {
    var producer: ActivableBoardProducer { get }

    func append(module: ModuleLoader)
}

protocol ModulePlugin {
    func apply(for main: MainComponent)
}

struct SomePlugin: ModulePlugin {
    struct ExProducer: SomeExProducer {
        let producer: ActivableBoardProducer

        func produce(identifier: SomeID) -> ActivatableBoard {
            var result: ActivatableBoard?
            switch identifier {
            case .some1:
                result = producer.produceBoard(identifier: "pub-some-1")
            case .some2:
                result = producer.produceBoard(identifier: "pub-some-2")
            }
            return result ?? NoBoard()
        }
    }

    func apply(for main: MainComponent) {
        let module = SomeModuleLoader(id: "some", exProducer: ExProducer(producer: main.producer)) {}
        main.append(module: module)
//        module.load(in: main)
    }
}

func main() {
    let mainComponent = ApplicationComponent()
    [
        SomePlugin(),
        SomePlugin()
    ].forEach {
        $0.apply(for: mainComponent)
    }
}
