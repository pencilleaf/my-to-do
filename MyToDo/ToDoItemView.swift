//
//  ToDoItemView.swift
//  MyToDo
//
//  Created by loan on 11/7/20.
//  Copyright © 2020 loan. All rights reserved.
//

import SwiftUI

struct ToDoItemView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: ToDoItem.getAllToDoItems()) var toDoItems:FetchedResults<ToDoItem>
    
    var item:ToDoItem
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        return dateFormatter
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
    
    var body: some View {
        HStack{
            Image(systemName: item.checked ? "checkmark.circle.fill": "circle")
                .imageScale(.large)
                .padding()
                .onTapGesture {
                    self.toggleChecked(item: self.item)
                }
            NavigationLink(destination: ToDoEditView(item: self.item)){
                VStack(alignment: .leading){
                    Text(item.title!)
                        .font(.headline)
                    Text("By \(item.dueAt!, formatter: dateFormatter)")
                        .font(.caption)
                }
            }
            
        }
    }
}

struct ToDoItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemView(item: ToDoItem())
    }
}
