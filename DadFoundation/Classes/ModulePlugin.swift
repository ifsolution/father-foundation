//
//  ModulePlugin.swift
//  DadFoundation
//
//  Created by FOLY on 5/22/21.
//

import Boardy
import Foundation

public protocol MainComponent: ModuleContainer {
    /// Main producer
    var producer: ActivableBoardProducer { get }

//    func append(module: ModuleLoader)
}

public protocol ModulePlugin {
    var identifier: BoardID { get }

    func apply(for main: MainComponent)
}
