 //
//  ContentView.swift
//  MyToDo
//
//  Created by loan on 9/7/20.
//  Copyright © 2020 loan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ToDoItem.getAllToDoItems()) var toDoItems:FetchedResults<ToDoItem>
    @State private var newToDoItem = ""
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("What's next?")){
                    HStack{
                        TextField("New item", text: self.$newToDoItem)
                        Button(action: {
                            let toDoItem = ToDoItem(context: self.managedObjectContext)
                            toDoItem.title = self.newToDoItem
                            toDoItem.createdAt = Date()
                            
                            do {
                                try self.managedObjectContext.save()
                            } catch {
                                print(error)
                            }
                            
                            self.newToDoItem = ""
                        }){
                            Image(systemName: "plus")
                                .imageScale(.large)
                        }
                    }
                }.font(.headline)
            }
            .navigationBarTitle(Text("My To Do"))
            .navigationBarItems(trailing: EditButton())
        }
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
