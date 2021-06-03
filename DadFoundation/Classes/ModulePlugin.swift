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

public protocol ModulePlugin {
    var identifier: BoardID { get }

    func apply(for main: MainComponent)
}
