//
//  DragBetweenWindowsApp.swift
//  DragBetweenWindows
//

import SwiftUI

@main
struct DragBetweenWindowsApp: App {
    @State private var dropbox = Dropbox()

    var body: some Scene {
        WindowGroup("Drag Between Windows", id: "source") {
            ContentView()
                .environment(dropbox)
        }

        WindowGroup("Drop Window", id: "drop") {
            DropWindowView()
                .environment(dropbox)
        }
    }
}
