//
//  Dotbou+CoreDataProperties.swift
//  dotbou
//
//  Created by 藤田佳恵 on 2018/03/08.
//  Copyright © 2018年 藤田佳恵. All rights reserved.
//
//

import Foundation
import CoreData


extension Dotbou {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dotbou> {
        return NSFetchRequest<Dotbou>(entityName: "Dotbou")
    }

    @NSManaged public var questionText: String?
    @NSManaged public var questionImage: String?
    @NSManaged public var questionAnswer: String?
    @NSManaged public var category: String?
    @NSManaged public var timeNow: NSDate?

}
