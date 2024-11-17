//
//  LocalSnap+CoreDataProperties.swift
//  
//
//  Created by 강민성 on 11/12/24.
//
//

import Foundation
import CoreData
import UIKit


extension LocalSnap {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalSnap> {
        return NSFetchRequest<LocalSnap>(entityName: "LocalSnap")
    }

    @NSManaged public var body: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: Int32
    @NSManaged public var image: [Data]?
    @NSManaged public var localTopic: LocalTopic?

}
