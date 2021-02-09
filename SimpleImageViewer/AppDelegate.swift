//
//  AppDelegate.swift
//  SimpleImageViewer
//
//  Created by Gualtiero Frigerio on 03/02/2021.
//

import Cocoa
import SwiftUI

/*
 If you can target macOS 11 you can use Scene
 */

@main
struct SimpleImageViewer: App {
    var filesViewModel:FilesViewModel
    var menuCommandsHandler:MenuCommandsHandler
    
    init() {
        filesViewModel = FilesViewModel()
        menuCommandsHandler = MenuCommandsHandler(withFilesViewModel: filesViewModel)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(filesViewModel: filesViewModel)
        }.commands {
            MenuCommands(commandsHandler: menuCommandsHandler).commands
        }
    }
}

/*

 this was created by Xcode when I started the macOS project
 
@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the window and set the content view.
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}
*/
