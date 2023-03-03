//
//  NetworkManager.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/03.
//

import Foundation
import Network

protocol NetworkStatusDelegate: AnyObject {
    func observeNetworkStatus(status: NetworkStatus)
}

public enum NetworkStatus {
    case none
    case connected
    case wifiMode
    case cellular
    case ethernet
    case notConnected
}

final class NetworkManager {

    public static let shared = NetworkManager()
    public weak var delegate: NetworkStatusDelegate?
    private var networkStatus: NetworkStatus = .none

    let monitor = NWPathMonitor()
    func startMonitoring() {
        monitor.start(queue: DispatchQueue.global())
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.networkStatus = .connected
                if path.usesInterfaceType(.wifi) {
                    self?.networkStatus = .wifiMode
                } else if path.usesInterfaceType(.cellular) {
                    self?.networkStatus = .cellular
                } else if path.usesInterfaceType(.wiredEthernet) {
                    self?.networkStatus = .ethernet
                }
            } else {
                self?.networkStatus = .notConnected
            }
            self?.delegate?.observeNetworkStatus(status: self?.networkStatus ?? .none)
        }
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
