//
//  ModulePlugin.swift
//  DadFoundation
//
//  Created by FOLY on 5/22/21.
//

import Boardy
import Foundation

extension MainOptions.Key {
    public static let environment = MainOptions.Key(rawValue: "environment")
}

public struct MainOptions {
    public struct Key: RawRepresentable, Hashable {
        public typealias RawValue = String

        public let rawValue: RawValue

        public init(rawValue: RawValue) {
            self.rawValue = rawValue
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(rawValue)
        }
    }

    private var values: [Key: Any]

    public init(_ values: [Key: Any] = [:]) {
        self.values = values
    }

    public static let `default` = MainOptions()

    public subscript<Value>(key: Key) -> Value? {
        return self[key] as? Value
    }

    public subscript(key: Key) -> Any {
        get {
            return values[key]
        }

        set {
            values[key] = newValue
        }
    }
}

public protocol MainComponent {
    var options: MainOptions { get }
    var producer: BoardDynamicProducer { get }
}

public protocol ModulePlugin: ModulePluginConvertible {
    var identifier: BoardID { get }

    func apply(for main: MainComponent)
}

public protocol ModulePluginConvertible {
    var plugins: [ModulePlugin] { get }
}

extension ModulePlugin {
    public var plugins: [ModulePlugin] { [self] }
}
