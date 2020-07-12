//
//  ToDoEditView.swift
//  MyToDo
//
//  Created by loan on 13/7/20.
//  Copyright © 2020 loan. All rights reserved.
//

import SwiftUI

struct ToDoEditView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ToDoItem.getAllToDoItems()) var toDoItems:FetchedResults<ToDoItem>
    
    var item:ToDoItem
    @State private var newToDoItem = ""
    @State private var dueAt = Date()
    
    var dateClosedRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .day, value:0, to: Date())!
        let max = Calendar.current.date(byAdding: .day, value:30, to: Date())!
        return min...max
    }
    
    var body: some View {
        VStack (alignment: .leading){
            Form {
            Section (header: Text("Details")){
                TextField("Description", text: self.$newToDoItem)
                    .onAppear {
                        self.newToDoItem = self.item.title!
                }
                DatePicker("Due Date",
                    selection: self.$dueAt,
                    in: self.dateClosedRange,
                    displayedComponents: [.hourAndMinute, .date])
                .datePickerStyle(DefaultDatePickerStyle())
                    .onAppear {
                        self.dueAt = self.item.dueAt!
                }
            }
            
            Section {
                Button(action: {
                    guard let index = self.toDoItems.firstIndex(of: self.item) else { return }
                    self.toDoItems[index].title = self.newToDoItem
                    self.toDoItems[index].dueAt = self.dueAt
                    
                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print(error)
                    }
                }){
                    HStack {
                        Text("Save")
                    }
                }
            }
        }
        .navigationBarTitle(Text("Edit"))
    }
}

struct ToDoEditView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoEditView(item: ToDoItem())
    }
}
}
