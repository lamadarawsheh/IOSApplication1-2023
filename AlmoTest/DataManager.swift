//
//  DataManager.swift
//  AlmoTest
//
//  Created by Lama Darawsheh on 13/03/2023.
//

import Foundation
import CoreData
import UIKit
class DataManager{
    
    func saveUser(_ user : UserClass){
        let appDelegate =
        UIApplication.shared.delegate as? AppDelegate
        
        let managedContext =
        appDelegate!.persistentContainer.viewContext
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.parent = managedContext
        
        privateMOC.perform { [self] in
            
            
            let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "SavedUsers")
            
            let predicate = NSPredicate(format: "id == %i", user.u.id)
            fetchRequest.predicate = predicate
            
            do {
                let fetchResults = try privateMOC.fetch(fetchRequest)
                
                if fetchResults.count != 0 {
                    // update
                    var managedObject = fetchResults[0]
                    
                    managedObject = getManagedObjectFromUser(managedObject, user)
                    try privateMOC.save()
                    managedContext.performAndWait {
                        do {
                            try managedContext.save()
                        } catch {
                            fatalError("Failure to save context: \(error)")
                        }
                    }
                    
                }
                else {
                    
                    //insert
                    let entity =
                    NSEntityDescription.entity(forEntityName: "SavedUsers",
                                               in: privateMOC)!
                    
                    var managedObject = NSManagedObject(entity: entity,
                                                        insertInto: privateMOC)
                    
                    managedObject = getManagedObjectFromUser(managedObject , user)
                    
                    do {
                        try privateMOC.save()
                        managedContext.performAndWait {
                            do {
                                try managedContext.save()
                            } catch {
                                fatalError("Failure to save context: \(error)")
                            }
                        }
                        
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                    
                }
                
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                
            }
            
            
        }
        
    }
    
    
    func savePhoto(_ photo : Photo){
        let appDelegate =
        UIApplication.shared.delegate as? AppDelegate
        
        let managedContext =
        appDelegate!.persistentContainer.viewContext
        
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.parent = managedContext
        
        privateMOC.perform { [self] in
            let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "SavedPhotos")
            
            
            fetchRequest.predicate = NSPredicate(format: "id == %@", String(photo.ph.id))
            
            
            do {
                let fetchResults = try privateMOC.fetch(fetchRequest)
                if fetchResults.count != 0 {
                    
                    // update
                    var managedObject = fetchResults[0]
                    
                    managedObject = getMnagedObjectFromPhoto(managedObject, photo)
                    try privateMOC.save()
                    managedContext.performAndWait {
                        do {
                            try managedContext.save()
                        } catch {
                            fatalError("Failure to save context: \(error)")
                        }
                    }
                    
                }
                else {
                    let entity =
                    NSEntityDescription.entity(forEntityName: "SavedPhotos",
                                               in: privateMOC)!
                    
                    var managedObject = NSManagedObject(entity: entity,
                                                        insertInto: privateMOC)
                    
                    managedObject = getMnagedObjectFromPhoto(managedObject , photo)
                    
                    do {
                        try privateMOC.save()
                        managedContext.performAndWait {
                            do {
                                try managedContext.save()
                            } catch {
                                fatalError("Failure to save context: \(error)")
                            }
                        }
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                    
                }
                
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
                
            }
            
        }
        
    }
    
    func getUserFromManagedObject(_ managedObject:NSManagedObject)->UserClass{
        
        let id = managedObject.value(forKeyPath: "id") as! Int
        let name = managedObject.value(forKeyPath: "name") as! String
        let username = managedObject.value(forKeyPath: "username") as! String
        let email = managedObject.value(forKeyPath: "email") as! String
        let phone = managedObject.value(forKeyPath: "phone") as! String
        let city = managedObject.value(forKeyPath: "city") as! String
        let street = managedObject.value(forKeyPath: "street") as! String
        let suite = managedObject.value(forKeyPath: "suite") as! String
        let zipcode = managedObject.value(forKeyPath: "zipcode") as! String
        let lat = managedObject.value(forKeyPath: "lat") as! String
        let lng = managedObject.value(forKeyPath: "lng") as! String
        let isFavorite = Bool(exactly: managedObject.value(forKeyPath: "isFavorite") as! NSNumber)
        let userStruct:User = User(id: id, name: name, username: username, email: email, phone: phone, address: Address(street: street, suite: suite, city: city, zipcode: zipcode, geo: Geo(lat: lat, lng: lng)), website: "", company: Company(name: "", catchPhrase: "", bs: ""))
        
        
        let user:UserClass = UserClass(u: userStruct)
        user.isFavorite = isFavorite!
        return user
        
        
    }
    func getManagedObjectFromUser(_ managedObject:NSManagedObject ,_ user:UserClass)->NSManagedObject{
        managedObject.setValue(user.u.name, forKeyPath: "name")
        managedObject.setValue(user.u.username, forKeyPath: "username")
        managedObject.setValue(user.u.email, forKeyPath: "email")
        managedObject.setValue(user.u.phone, forKeyPath: "phone")
        managedObject.setValue(user.u.id, forKeyPath: "id")
        managedObject.setValue(user.u.address.city, forKeyPath: "city")
        managedObject.setValue(user.u.address.street, forKeyPath: "street")
        managedObject.setValue(user.u.address.suite, forKeyPath: "suite")
        managedObject.setValue(user.u.address.zipcode, forKeyPath: "zipcode")
        managedObject.setValue(user.u.address.geo.lat, forKeyPath: "lat")
        managedObject.setValue(user.u.address.geo.lng, forKeyPath: "lng")
        managedObject.setValue(NSNumber(value: user.isFavorite) , forKeyPath: "isFavorite")
        
        return managedObject
    }
    
    
    func getPhotoFromManagedObject(_ managedObject:NSManagedObject)->Photo{
        
        let id = managedObject.value(forKeyPath: "id") as! Int
        let title = managedObject.value(forKeyPath: "title") as! String
        let albumId = managedObject.value(forKeyPath: "albumId") as! Int
        let thumbnailUrl = managedObject.value(forKeyPath: "thumbnailUrl") as! String
        
        
        let photoStruct:Photos = Photos(albumId: albumId, id: id, title: title, url: "", thumbnailUrl: thumbnailUrl)
        
        let photo:Photo = Photo(ph: photoStruct)
        return photo
        
    }
    func getMnagedObjectFromPhoto(_ managedObject:NSManagedObject ,_ photo:Photo)->NSManagedObject{
        managedObject.setValue(photo.ph.id, forKeyPath: "id")
        managedObject.setValue(photo.ph.albumId, forKeyPath: "albumId")
        managedObject.setValue(photo.ph.title, forKeyPath: "title")
        managedObject.setValue(photo.ph.thumbnailUrl, forKeyPath: "thumbnailUrl")
        
        
        return managedObject
    }
    func fetchUsers()->[UserClass]{
        var savedUsers:[UserClass] = []
        let appDelegate =
        UIApplication.shared.delegate as? AppDelegate
        
        let managedContext =
        appDelegate!.persistentContainer.viewContext
        
        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "SavedUsers")
        
        do {
            let users = try managedContext.fetch(fetchRequest)
            for user in users
            {
                savedUsers.append(getUserFromManagedObject(user))
            }
            savedUsers.sort( by: {$0.u.id < $1.u.id})
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return savedUsers
    }
    
    func fetchPhotos()->[Photo]{
        var savedPhotos:[Photo] = []
        let appDelegate =
        UIApplication.shared.delegate as? AppDelegate
        
        let managedContext =
        appDelegate!.persistentContainer.viewContext
        
        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "SavedPhotos")
        
        do {
            let photos = try managedContext.fetch(fetchRequest)
            for photo in photos
            {
                savedPhotos.append(getPhotoFromManagedObject(photo))
            }
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return savedPhotos
    }
    
    
}
