//
//  WebSocketManager.swift
//  TrendBit
//
//  Created by 강민수 on 4/17/25.
//

import Foundation
import RxSwift

final class WebSocketManager {
    
    static let shared = WebSocketManager()
    
    private var webSocket: URLSessionWebSocketTask?
    private var tickerCache: [String: TickerResponseDTO] = [:]
    private let tickerSubject = PublishSubject<[TickerResponseDTO]>()
    var tickerObservable: Observable<[TickerResponseDTO]> {
        return tickerSubject.asObservable()
    }
    
    private let socketErrorSubject = PublishSubject<Error>()
    var socketErrorObservable: Observable<Error> {
        return socketErrorSubject.asObservable()
    }
    
    private init() { }
    
    /// 터널 연결
    func connect() {
        guard let url = URL(string: Secret.upbitSoketURL) else {
            return
        }
        
        let session = URLSession(configuration: .default)
        webSocket = session.webSocketTask(with: url)
        webSocket?.resume()
        sendSubscription()
        receiveMessage()
    }
    
    /// 터널 해제
    func disconnect() {
        webSocket?.cancel(with: .goingAway, reason: nil)
        webSocket = nil
    }
    
    /// 서버에 원하는 값 요청
    func sendSubscription() {
        let payload: [[String: Any]] = [
            ["ticket": "TrendBit-socket"],
            ["type": "ticker", "codes": markets],
            ["format": "SIMPLE"]
        ]
        
        guard let data = try? JSONSerialization.data(withJSONObject: payload, options: []) else { return }
        
        webSocket?.send(.data(data)) { [weak self] error in
            if let error {
                self?.socketErrorSubject.onNext(error)
            }
        }
    }
    
    /// 서버에서 값을 계속 받아오기 (재귀 이용)
    func receiveMessage() {
        webSocket?.receive(completionHandler: { result in
            switch result {
            case .success(let message):
                if let data = self.extractData(from: message) {
                    self.handle(data: data)
                }
            case .failure(let failure):
                self.socketErrorSubject.onNext(failure)
            }
            
            self.receiveMessage()
        })
    }
    
    private func extractData(from message: URLSessionWebSocketTask.Message) -> Data? {
        switch message {
        case .string(let str): return str.data(using: .utf8)
        case .data(let d):     return d
        @unknown default:      return nil
        }
    }
    
    private func handle(data: Data) {
        do {
            let dto = try JSONDecoder().decode(TickerResponseDTO.self, from: data)
            tickerCache[dto.code] = dto
            
            let list = Array(tickerCache.values)
            tickerSubject.onNext(list)
        } catch {
            socketErrorSubject.onNext(error)
        }
    }
}
