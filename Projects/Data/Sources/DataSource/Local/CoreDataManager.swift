//
//  CoreDataManager.swift
//  Data
//
//  Created by 강민성 on 11/10/24.
//  Copyright © 2024 com.team.snaplog. All rights reserved.
//

import UIKit
import CoreData

public final class CoreDataManager {
    public static let shared = CoreDataManager()

    private var persistentContainer: NSPersistentContainer = {
            let momdName = "LocalData"

            guard let modelURL = Bundle.module.url(forResource: momdName, withExtension: "momd") else {
                fatalError("Error loading model from bundle")
            }

            guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
                fatalError("Error initializing mom from: \(modelURL)")
            }

            let container = NSPersistentContainer(name: momdName, managedObjectModel: mom)

            container.loadPersistentStores(completionHandler: { _, error in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()



    private init() {}

    public func saveContext() {
        let context = persistentContainer.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                print("CoreData 저장 실패: \(error)")
            }
        }
    }

    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    public func createTopic(emoji: String, title: String) -> LocalTopic {
        print(persistentContainer.name)
        let topic = LocalTopic(context: context)
        topic.id = Int32(getTopicId())
        topic.emoji = emoji
        topic.title = title
        saveContext()
        return topic
    }

    public func getTopicId() -> Int {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = LocalTopic.fetchRequest()

        fetchRequest.resultType = .dictionaryResultType

        // id키값 찾기
        let keypathExp = NSExpression(forKeyPath: "id")
        // 배열에 id들 넣고 max함수 돌리기
        let maxExp = NSExpression(forFunction: "max:", arguments: [keypathExp])
        let maxIdDescription = NSExpressionDescription()
        maxIdDescription.expression = maxExp
        maxIdDescription.name = "MaxId"
        maxIdDescription.expressionResultType = .integer32AttributeType
        fetchRequest.propertiesToFetch = [maxIdDescription]

        do {
            if let result = try context.fetch(fetchRequest) as? [[String: Int]],
               let maxId = result.first?["MaxId"] {
                return maxId + 1
            }
        } catch {
            print("MaxId 가져오기 실패 \(error)")
        }

        return 1
    }

    public func fetchAllTopics() -> [LocalTopic] {
        let request: NSFetchRequest<LocalTopic> = LocalTopic.fetchRequest()

        do {
            return try context.fetch(request)
        } catch {
            print("topic fetch 실패 \(error)")
            return []
        }
    }

    public func updateTopic(topic: LocalTopic, newEmoji: String, newTitle: String) {
        topic.emoji = newEmoji
        topic.title = newTitle
        saveContext()
    }

    public func deleteTopic(topic: LocalTopic) {
        context.delete(topic)
        saveContext()
    }

    public func createSnap(topic: LocalTopic, date: Date, body: String?, images: [UIImage]) -> LocalSnap {
        let snap = LocalSnap(context: context)
        snap.id = Int32(getSnapId())
        snap.body = body
        snap.date = date
        snap.image = images.map { $0.pngData() ?? Data() }
        snap.localTopic = topic
        saveContext()
        return snap
    }

    public func getSnapId() -> Int {
        let fetchrequest: NSFetchRequest<NSFetchRequestResult> = LocalSnap.fetchRequest()

        fetchrequest.resultType = .dictionaryResultType

        // id키값 찾기
        let keypathExp = NSExpression(forKeyPath: "id")
        // 배열에 id들 넣고 max함수 돌리기
        let maxExp = NSExpression(forFunction: "max:", arguments: [keypathExp])
        let maxIdDescription = NSExpressionDescription()
        maxIdDescription.expression = maxExp
        maxIdDescription.name = "MaxId"
        maxIdDescription.expressionResultType = .integer32AttributeType
        fetchrequest.propertiesToFetch = [maxIdDescription]

        do {
            if let result = try context.fetch(fetchrequest) as? [[String: Int]],
               let maxId = result.first?["maxId"] {
                return maxId + 1
            }
            
        } catch {
            print("MaxId 가져오기 실패 \(error)")
        }
        return 1
    }

    public func fetchSnaps(topic: LocalTopic) -> [LocalSnap] {
        let request: NSFetchRequest<LocalSnap> = LocalSnap.fetchRequest()

        request.predicate = NSPredicate(format: "topic == %@", topic)

        do {
            return try context.fetch(request)
        } catch {
            print("Topic에서 Snap fetching 실패: \(error)")
            return []
        }
    }

    public func updateSnap(snap: LocalSnap, newBody: String?, newImages: [UIImage], newDate: Date) {
        snap.body = newBody
        snap.image = newImages.map { $0.pngData() ?? Data() }
        snap.date = newDate
        saveContext()
    }

    public func deleteSnap(snap: LocalSnap) {
        context.delete(snap)
        saveContext()
    }
}
