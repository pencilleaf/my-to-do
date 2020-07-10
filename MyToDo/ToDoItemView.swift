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
    var createdAt:String = ""
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(title)
                    .font(.headline)
                Text(createdAt)
                    .font(.caption)
            }
        }
    }
}

struct ToDoItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemView(title: "My todo",
                     createdAt: "Today")
    }
}
