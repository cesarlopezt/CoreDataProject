//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Cesar Lopez on 4/1/23.
//

import CoreData
import SwiftUI

struct ShipsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == %@", "Star Wars")) var ships: FetchedResults<Ship>
    
    var body: some View {
        VStack {
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown")
            }
            Button("Add examples") {
                let ship1 = Ship(context: moc)
                ship1.name = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: moc)
                ship2.name = "Defiant"
                ship2.universe = "Star Trek"
                
                let ship3 = Ship(context: moc)
                ship3.name = "Millennium Falcon"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: moc)
                ship4.name = "Executor"
                ship4.universe = "Star Wars"
                
                try? moc.save()
            }
        }
    }
}

struct SingersView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    var body: some View {
        VStack {
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            Button("Add examples") {
                let singer1 = Singer(context: moc)
                singer1.firstName = "Taylor"
                singer1.lastName = "Swift"
                
                let singer2 = Singer(context: moc)
                singer2.firstName = "Ed"
                singer2.lastName = "Sheeran"
                
                let singer3 = Singer(context: moc)
                singer3.firstName = "Adele"
                singer3.lastName = "Adkins"
                
                try? moc.save()
            }
            
            Button("Show A") {
                lastNameFilter = "A"
            }
            
            Button("Show S") {
                lastNameFilter = "S"
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            ShipsView()
                .tabItem {
                    Label("Ships", systemImage: "airplane.departure")
                }
            SingersView()
                .tabItem {
                    Label("Singers", systemImage: "music.mic")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
