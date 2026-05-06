//
//  DeveloperNotes.swift
//  DragBetweenWindows
//

import Foundation

enum DeveloperNotes {
    static let notes: [Note] = [
        Note(
            title: "Why DragBetweenWindows exists",
            body: """
            This app is the cross-window drag-and-drop demo from Build-Along 10 of \
            Claude's X26 Swift 6 Bible. Two windows. Drag a token from the left, \
            drop it on the right. The cross-scene payload delivery IS the teaching \
            point.
            """
        ),
        Note(
            title: "Two windows, one App",
            body: """
            The app declares two WindowGroups in its body: one for the Source list, \
            one for the Drop window. Each WindowGroup has its own id (\"source\" \
            and \"drop\"), and the toolbar's Open Drop Window button uses \
            @Environment(\\.openWindow)(id: \"drop\") to spawn the second one. On \
            Mac this gives you genuine separate windows; on iPad the second window \
            opens via Stage Manager.
            """
        ),
        Note(
            title: "Transferable, not NSItemProvider",
            body: """
            Token conforms to Transferable using CodableRepresentation with a custom \
            UTType. This is the modern SwiftUI path — .draggable(token) on the \
            source row hands the live model object across the drag, and \
            .dropDestination(for: Token.self) on the destination receives it as a \
            real Swift value, not raw bytes.
            """
        ),
        Note(
            title: "Shared state via Dropbox",
            body: """
            The Source and Drop windows are separate scenes — they don't share view \
            hierarchies. To make a drop in window B show up in window B's list, \
            both windows reference the same Dropbox ObservableObject injected at \
            the App level. Dropbox is the single store of dropped tokens; both \
            windows observe it.
            """
        ),
        Note(
            title: "isTargeted feedback matters",
            body: """
            Drop targets need to tell the user \"yes, you can release here.\" The \
            drop zone's dashed border switches to the accent color and the label \
            changes to \"Release to drop\" while the drag hovers. That single bit \
            of feedback is what separates a drop zone that feels alive from one \
            that feels broken.
            """
        ),
        Note(
            title: "Distribution",
            body: """
            DragBetweenWindows ships as a GitHub clone-and-build project, not an \
            App Store release. App Review's Guideline 2.2 reads single-concept \
            demos as demos and rejects them. Readers clone the repo, open it in \
            Xcode, and build it. The reader becoming the developer is exactly the \
            teaching outcome.
            """
        )
    ]

    struct Note: Identifiable {
        let id: UUID = UUID()
        let title: String
        let body: String
    }
}
