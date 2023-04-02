//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Cesar Lopez on 4/1/23.
//

import CoreData
import SwiftUI

enum Predicate: String {
    case beginsWith = "BEGINSWITH"
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(predicate: Predicate, filterKey: String, filterValue: String, sortDescriptors: [SortDescriptor<T>], @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(
            sortDescriptors: sortDescriptors,
            predicate: filterValue.isEmpty ? nil : NSPredicate(format: "%K \(predicate.rawValue) %@", filterKey, filterValue)
        )
        self.content = content
    }
}

//struct FilteredList_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredList()
//    }
//}
