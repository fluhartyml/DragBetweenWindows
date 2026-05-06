//
//  DropWindowView.swift
//  DragBetweenWindows
//

import SwiftUI

struct DropWindowView: View {
    @Environment(Dropbox.self) private var dropbox
    @State private var isTargeted: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                dropZone
                Divider()
                droppedList
            }
            .navigationTitle("Drop Window")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Clear", role: .destructive) {
                        dropbox.clear()
                    }
                    .disabled(dropbox.dropped.isEmpty)
                }
            }
        }
    }

    private var dropZone: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(
                    isTargeted ? Color.accentColor : Color.secondary.opacity(0.4),
                    style: StrokeStyle(lineWidth: 2, dash: [8, 6])
                )
            Text(isTargeted ? "Release to drop" : "Drop a token here")
                .font(.title3)
                .foregroundStyle(isTargeted ? Color.accentColor : .secondary)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .padding(20)
        .dropDestination(for: Token.self) { tokens, _ in
            for token in tokens { dropbox.accept(token) }
            return true
        } isTargeted: { targeted in
            withAnimation(.easeInOut(duration: 0.15)) {
                isTargeted = targeted
            }
        }
    }

    private var droppedList: some View {
        Group {
            if dropbox.dropped.isEmpty {
                ContentUnavailableView(
                    "No tokens yet",
                    systemImage: "tray",
                    description: Text("Drag tokens from the Source window into the dashed area above.")
                )
            } else {
                List {
                    Section {
                        ForEach(dropbox.dropped) { token in
                            TokenRow(token: token)
                        }
                    } header: {
                        Text("Dropped (\(dropbox.dropped.count))")
                    }
                }
            }
        }
    }
}

#Preview {
    DropWindowView()
        .environment(Dropbox())
}
