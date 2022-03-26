//
//  CompanyDetail.swift
//  CoreDataIntro
//
//  Created by Sarika on 25.03.22.
//

import SwiftUI

struct CompanyDetail: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var company : Company
    @State private var employeeName : String = ""
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Employee name", text: $employeeName)
                        .textFieldStyle(.roundedBorder)
                    Button(action: addEmployee) {
                        Image(systemName: "plus")
                    }
                }.padding()
                
                Spacer()
                List {
                    ForEach(company.employeesArray) { employee in
                        Text(employee.unwrappedName)
                    }.onDelete(perform: deleteEmployee)
                }
            }.navigationTitle("Employees")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func addEmployee() {
        let employee = Employee(context: viewContext)
        employee.name = employeeName
        company.addToEmployee(employee)
        PersistenceController.shared.saveContext()
    }
    
    private func deleteEmployee(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let employee = company.employeesArray[index]
                viewContext.delete(employee)
                PersistenceController.shared.saveContext()
            }
        }
    }
    
}

struct CompanyDetail_Previews: PreviewProvider {
    static var previews: some View {
       
        let viewContext = PersistenceController.preview.container.viewContext
        let newCompany = Company(context: viewContext)
        
        newCompany.name = "Apple Inc"
        
        let employee1 = Employee(context: viewContext)
        employee1.name = "Darshan"
        
        
        let employee2 = Employee(context: viewContext)
        employee2.name = "Pritam"
        
        newCompany.addToEmployee(employee1)
        newCompany.addToEmployee(employee2)
        
        return CompanyDetail(company: newCompany)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
