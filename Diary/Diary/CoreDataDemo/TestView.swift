//
//  TestView.swift
//  Diary
//
//  Created by TAEHYOUNG KIM on 2023/03/01.
//

import SwiftUI
import CoreData

///https://www.answertopia.com/swiftui/a-swiftui-core-data-tutorial/

struct TestView: View {
    @State var name: String = ""
    @State var quantity: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Product.entity(), sortDescriptors: [NSSortDescriptor(key: "quantity", ascending: true)])
    private var products: FetchedResults<Product>
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Product name", text: $name)
                TextField("Product quantity", text: $quantity)
                
                HStack {
                    Spacer()
                    Button("Add") {
                        addProduct()
                        name = ""
                        quantity = ""
                    }
                    Spacer()
                    Button("Clear") {
                        name = ""
                        quantity = ""
                    }
                    
                    Spacer()
                    NavigationLink("Find") {
                        ResultsView(name: name, viewContext: viewContext)
                    }
                    
                    Spacer()
                    Button("Array check") {
                        print(products)
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                List {
                    ForEach(products) { product in
                        HStack {
                            Text(product.name ?? "Not found")
                            Spacer()
                            Text(product.quantity ?? "Not found")
                        }
                    }
                    .onDelete(perform: deleteProducts)

                }
                .navigationTitle("Product Database")
            }
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    private func addProduct() {
        
        withAnimation {
            let product = Product(context: viewContext)
            product.name = name
            product.quantity = quantity
            
            saveContext()
        }
    }
    
    private func deleteProducts(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)
                saveContext()
            }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occured: \(error)")
        }
    }
}

//MARK: -Search results view
struct ResultsView: View {
    var name: String
    var viewContext: NSManagedObjectContext
    @State var matches: [Product]?

    var body: some View {
       
        VStack {
            List {
                ForEach(matches ?? []) { match in
                    HStack {
                        Text(match.name ?? "Not found")
                        Spacer()
                        Text(match.quantity ?? "Not found")
                    }
                }
            }
            .navigationTitle("Results")
        }
        .task {
                let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
                
                fetchRequest.entity = Product.entity()
                fetchRequest.predicate = NSPredicate(
                    format: "name CONTAINS %@", name // LIKE 키워드를 사용하면 똑같은거
                )
                matches = try? viewContext.fetch(fetchRequest)
            }
    }
}

struct TestView_Previews: PreviewProvider {
    
   static let persistenceController = PersistenceController.shared

    static var previews: some View {
        TestView()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}

