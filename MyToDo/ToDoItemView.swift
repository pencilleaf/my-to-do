//
//  ToDoItemView.swift
//  MyToDo
//
//  Created by loan on 11/7/20.
//  Copyright © 2020 loan. All rights reserved.
//

import SwiftUI

struct ToDoItemView: View {
    var title:String = ""
    var dueAt:Date
    var checked:Bool
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .long
        return dateFormatter
    }
    
    var body: some View {
        HStack{
            Image(systemName: checked ? "checkmark.circle.fill": "circle")
                .imageScale(.large)
                .padding()
            VStack(alignment: .leading){
                Text(title)
                    .font(.headline)
                Text("\(dueAt, formatter: dateFormatter)")
                    .font(.caption)
            }
        }
    }
}

struct ToDoItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemView(title: "My todo",
                     dueAt: Date(),
                     checked: true)
    }
}
