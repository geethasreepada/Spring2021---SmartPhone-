//
//  Tab.swift
//  Yammer
//
//  Created by alkadios on 4/27/21.
//

import Foundation

struct Tab {
    
    static let web = Info(name: "Data", imageSystemName: "globe")
    static let news = Info(name: "News", imageSystemName: "dot.radiowaves.left.and.right")
}

extension Tab {
    struct Info {
        var name: String
        var imageSystemName: String
    }
}
