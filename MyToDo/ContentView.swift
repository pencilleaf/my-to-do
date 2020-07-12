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
    @State private var dueAt = Date()
    
    var body: some View {
        NavigationView{
            List{
                Section(header: Text("To Dos")){
                    ForEach(self.toDoItems){toDoItem in
                        ToDoItemView(title: toDoItem.title!, dueAt: Date(), checked: toDoItem.checked)
                        .onTapGesture {
                            self.toggleChecked(item: toDoItem)
                        }
                    }
                    .onDelete {indexSet in
                        let deleteItem = self.toDoItems[indexSet.first!]
                        self.managedObjectContext.delete(deleteItem)
                        
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                    }
                }
                Section(header: Text("What's next?")){
                    HStack{
                        TextField("New item", text: self.$newToDoItem)
                        Button(action: {
                            let toDoItem = ToDoItem(context: self.managedObjectContext)
                            toDoItem.title = self.newToDoItem
                            toDoItem.createdAt = Date()
                            toDoItem.dueAt = self.dueAt
                            toDoItem.checked = false
                            
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
            .navigationBarTitle(Text("To Do's"))
            .navigationBarItems(trailing: EditButton())
        }
    }
    
    func toggleChecked(item: ToDoItem?) {
        guard let item = item else { return }
        guard let index = self.toDoItems.firstIndex(of: item) else { return }
        self.toDoItems[index].checked.toggle()
        
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
