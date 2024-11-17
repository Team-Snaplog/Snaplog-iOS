//
//  LocalTopic+CoreDataProperties.swift
//  
//
//  Created by 강민성 on 11/12/24.
//
//

import Foundation
import CoreData


extension LocalTopic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalTopic> {
        return NSFetchRequest<LocalTopic>(entityName: "LocalTopic")
    }

    @NSManaged public var emoji: String?
    @NSManaged public var id: Int32
    @NSManaged public var title: String?

}
