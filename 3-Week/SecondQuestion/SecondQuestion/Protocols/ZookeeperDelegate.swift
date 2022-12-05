//
//  ZookeeperDelegate.swift
//  SecondQuestion
//
//  Created by Habip Yesilyurt on 20.11.2022.
//

import Foundation

protocol ZookeeperDelegate: AnyObject {
    func zookeeperWasRegistered(_ zookeepers: [Zookeeper])
}
