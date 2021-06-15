//
//  ModulePlugin.swift
//  DadFoundation
//
//  Created by FOLY on 5/22/21.
//

import Boardy
import Foundation

public protocol MainComponent {
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
