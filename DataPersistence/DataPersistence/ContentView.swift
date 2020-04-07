//
//  ContentView.swift
//  DataPersistence
//
//  Created by Archna  on 31/03/20.
//  Copyright © 2020 Archna . All rights reserved.
//

import SwiftUI
struct Item: Encodable, Decodable {
    var name: String
    var quantity: Int
}

struct ContentView: View {
    let item1 = Item(name: "apple", quantity: 2)
    let item2 = Item(name: "banana", quantity: 3)
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    let newDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("data").path
    
    let name = "John Doe"
    var body: some View {
        print(dataFilePath!)
        loadData()
        return Text("Hello, World!")
    }
    
    func saveData() {
        UserDefaults.standard.set(name, forKey: "name")
               let array = [item1,item2]
               let encoder = PropertyListEncoder()
               do {
                   let encodedData = try encoder.encode(array)
                   try encodedData.write(to: dataFilePath!)
               }
               catch {
                  print("Error")
               }
    }
    
    func loadData() {
        try? FileManager.default.createDirectory(atPath: newDir!,
                         withIntermediateDirectories: true, attributes: nil)
        print(FileManager.default.currentDirectoryPath)
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            if let array = try? decoder.decode([Item].self,from: data) {
                print(array)
            }
        }
        
        do {
            let filelist = try FileManager.default.contentsOfDirectory(atPath: "/")

            for filename in filelist {
                print(filename)
            }
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
