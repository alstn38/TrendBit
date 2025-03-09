//
//  CoinFavoriteService.swift
//  TrendBit
//
//  Created by 강민수 on 3/9/25.
//

import Foundation
import RealmSwift

protocol CoinFavoriteService {
    func isFavoriteCoin(at coinID: String) -> Bool
    func createItem(coinID: String) throws
    func deleteItem(coinID: String) throws
}

final class DefaultCoinFavoriteService: CoinFavoriteService {
    
    private let realm = try! Realm()
    
    func isFavoriteCoin(at coinID: String) -> Bool {
        if realm.object(ofType: CoinFavoriteDTO.self, forPrimaryKey: coinID) == nil {
            return false
        } else {
            return true
        }
    }
    
    func createItem(coinID: String) throws {
        do {
            try realm.write {
                let data = CoinFavoriteDTO(coinID: coinID)
                realm.add(data)
            }
        } catch {
            throw LocalError.createError
        }
    }
    
    func deleteItem(coinID: String) throws {
        guard let deleteData = realm.object(ofType: CoinFavoriteDTO.self, forPrimaryKey: coinID) else { return }
        
        do {
            try realm.write {
                realm.delete(deleteData)
            }
        } catch {
            throw LocalError.deleteError
        }
    }
}
