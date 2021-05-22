//
//  CoreModuleInterface.swift
//  DadFoundation
//
//  Created by NGUYEN CHI CONG on 5/14/21.
//

import Boardy
import Foundation

/// For container module which loads and activates feature modules.
public protocol ModuleContainer {
    func registerBoard(_ factory: @escaping (BoardID) -> ActivatableBoard, with identifier: BoardID)
}

extension ModuleContainer {
    public func registerBoard(by producer: ActivableBoardProducer, with identifier: BoardID) {
        self.registerBoard({ id in
            producer.produceBoard(identifier: id) ?? NoBoard()
        }, with: identifier)
    }
}

/// For feature module which will be loaded in container.
public protocol ModuleLoader {
    var identifier: String { get }

    func load(in container: ModuleContainer)
}
