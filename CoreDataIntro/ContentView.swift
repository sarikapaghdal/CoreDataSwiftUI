//
//  ContentView.swift
//  CoreDataIntro
//
//  Created by Sarika on 24.03.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext  //getting value from our dictionary
    
    @State private var companyName : String = ""
    
    @FetchRequest(entity: Company.entity() ,
                  sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]
    )
    private var companies : FetchedResults<Company>
    
    var body: some View {
        
        NavigationView {
            VStack {
                HStack {
                    TextField("Company name", text: $companyName) //binding textfield value with our State property
                        .textFieldStyle(.roundedBorder)
                    Button(action: addCompany) {
                        Image(systemName: "plus")
                    }
                }.padding()
                
                List {
                    ForEach(companies) { company in
                        NavigationLink(destination: CompanyDetail(company: company)) {
                            Text(company.name ?? " ")
                        }
                    }.onDelete(perform: deleteCompany)
                }
            } //: VSTACK
            .navigationTitle("Companies")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func deleteCompany(offsets : IndexSet) {
        withAnimation {
            offsets.map { companies[$0] }.forEach(viewContext.delete)
                PersistenceController.shared.saveContext()
        }
    }
    
    private func addCompany() {
        withAnimation {
            let newCompany = Company(context: viewContext)
            newCompany.name = companyName
            PersistenceController.shared.saveContext()
        }
    }
}

//there are 2 coredata stacks we're using in our app. one is persistent and other in canvas, canvas viewcontext is different slightly
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //using preview viewContext
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
