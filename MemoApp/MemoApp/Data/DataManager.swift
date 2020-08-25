//
//  DataManager.swift
//  MemoApp
//
//  Created by 김상진 on 2020/06/29.
//  Copyright © 2020 kipCalm. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
    private init(){
        
    }

    //coreData에서 수행하는 대부분의 작업은 context 객체가 담당한다.
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var memoList = [Memo]()
    
    //DB에서 data를 가져오는 것을 fetch라고 한다.
    func fetchMemo() {
        let request: NSFetchRequest<Memo> = Memo.fetchRequest()
        
        let sortByDateDesc = NSSortDescriptor(key: "insertDate", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        do{
            memoList = try mainContext.fetch(request)
        }catch{
            print(error)
        }
        
    }
    
    
    func addNewMemo(_ memo: String?) {
        //Memo는 coreData가 만들어준 instance니까 context를 넣어줘야해
        let newMemo = Memo(context: mainContext)
        newMemo.content = memo
        newMemo.insertDate = Date()
        
        memoList.insert(newMemo, at: 0)
        
        saveContext()   //이걸 호출해줘야 coreData에 저장됨.
    }
    
    
    func deleteMemo(_ memo: Memo?){
        if let memo = memo {
            mainContext.delete(memo)
            saveContext()
        }
    }
    
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MemoApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
