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
    @State private var lastNameFilter = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                FilteredList(
                    predicate: .beginsWith,
                    filterKey: "lastName",
                    filterValue: lastNameFilter,
                    sortDescriptors: []
                ) { (singer: Singer) in
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
                    
                    let singer4 = Singer(context: moc)
                    singer4.firstName = "Selena"
                    singer4.lastName = "Gomez"
                    
                    let singer5 = Singer(context: moc)
                    singer5.firstName = "Billie"
                    singer5.lastName = "Eilish"
                    
                    let singer6 = Singer(context: moc)
                    singer6.firstName = "Katy"
                    singer6.lastName = "Perry"
                    
                    
                    try? moc.save()
                }
                
                //            Button("Show A") {
                //                lastNameFilter = "A"
                //            }
                //
                //            Button("Show S") {
                //                lastNameFilter = "S"
                //            }
            }
        }
        .searchable(text: $lastNameFilter)
    }
}

struct CandiesView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    
    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            Button("Add examples") {
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                let candy2 = Candy(context: moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"
                
                let candy4 = Candy(context: moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"

                try? moc.save()
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
            CandiesView()
                .tabItem {
                    Label("Candies", systemImage: "birthday.cake.fill")
                }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
