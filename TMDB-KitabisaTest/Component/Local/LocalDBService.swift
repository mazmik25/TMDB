//
//  LocalDBService.swift
//  TMDB-KitabisaTest
//
//  Created by Azmi Muhammad on 22/02/20.
//  Copyright © 2020 Azmi Muhammad. All rights reserved.
//

import CoreData

typealias OnLocalSuccess = (()->Void)?
typealias OnGetLocalData<T> = (([T])->Void)?

class LocalDBService<T: NSManagedObject, E> {
    
    let context: NSManagedObjectContext!
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func save(input: E, onSuccess: OnLocalSuccess, onFailure: OnFailed) {
        
    }
    
    func load(onSuccess: OnGetLocalData<T>, onFailure: OnFailed) {
        let fetchRequest: NSFetchRequest = FavoriteMovie.fetchRequest()
        do {
            let value: [T] = try context.fetch(fetchRequest) as! [T]
            onSuccess?(value)
        } catch {
            print(error)
            onFailure?(error)
        }
    }
    
    func load(predicate: NSPredicate, onSuccess: OnGetLocalData<T>, onFailure: OnFailed) {
        let fetchRequest: NSFetchRequest = T.fetchRequest()
        fetchRequest.predicate = predicate
        do {
            let movies: [T] = try context.fetch(fetchRequest) as! [T]
            onSuccess?(movies)
        } catch {
            print(error)
            onFailure?(error)
        }
    }
    
    func delete(entity: T, onSuccess: OnLocalSuccess, onFailure: OnFailed) {
        context.delete(entity)
        do {
            try context.save()
            onSuccess?()
        } catch {
            onFailure?(error)
        }
    }
}
