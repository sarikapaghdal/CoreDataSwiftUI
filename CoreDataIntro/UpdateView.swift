//
//  UpdateView.swift
//  CoreDataIntro
//
//  Created by Sarika on 24.03.22.
//

import SwiftUI
/*
 Update company step by step
 1 - Add @StateObject
 2 - Receive in new View - adding a company as observable
 3 - Update the company
 */
struct UpdateView: View {
    @StateObject var company : Company //Coredata Company Class , when this company var changes then UpdateView will rerender itself
    
    @State private var companyName : String = "" //Textfield value
    
    var body: some View {
        
        VStack {
            HStack {
                TextField("Update Company Name", text: $companyName) //binding textfield value with our State property
                    .textFieldStyle(.roundedBorder)
                Button(action: updateCompany) {
                    Image(systemName: "arrowshape.turn.up.left")
                }
            }.padding()//: HSTACK
            Text(company.name ?? "")
            Spacer()
        }
    }
    
    private func updateCompany() {
            withAnimation {
                company.name = companyName
                PersistenceController.shared.saveContext()
            }
    }
}

//Setting up preview update

struct UpdateView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let newCompany = Company(context: viewContext)
        newCompany.name = "IBM"
        
        return UpdateView(company: newCompany)
            .environment(\.managedObjectContext , PersistenceController.preview.container.viewContext)
    }
}
