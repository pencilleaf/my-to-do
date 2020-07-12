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
    @State var showPopover = false
    
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .day, value:0, to: Date())!
        let max = Calendar.current.date(byAdding: .day, value:30, to: Date())!
        return min...max
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                List{
                    ForEach(self.toDoItems){toDoItem in
                        ToDoItemView(item: toDoItem)
                        
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
                Button(action: {
                    self.showPopover = true
                }) {
                    HStack{
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width:20, height:20)
                        Text("Add new task")
                    }
                    
                    }.padding()
                .popover(isPresented: $showPopover){
                    NavigationView {
                        Form {
                            Section (header: Text("Details")){
                                TextField("Add a new task", text: self.$newToDoItem)
                                DatePicker("Due Date",
                                    selection: self.$dueAt,
                                    in: self.dateClosedRange,
                                    displayedComponents: [.hourAndMinute, .date])
                                .datePickerStyle(DefaultDatePickerStyle())
                            }
                            
                            Section {
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
                                    self.dueAt = Date()
                                    self.showPopover.toggle()
                                }){
                                    HStack {
                                        Image(systemName: "plus")
                                        Text("Add new task")
                                    }
                                }
                            }
                        }
                        .navigationBarTitle(Text("Add Task"))
                            .navigationBarItems(leading: Button(action: {
                                self.showPopover.toggle()
                            }){
                                Text("Cancel")
                            })
                    }
                }
                
            }
            .navigationBarTitle(Text("To Do's"))
            .navigationBarItems(trailing: EditButton())
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
}
