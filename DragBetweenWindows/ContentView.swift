//
//  ContentView.swift
//  DragBetweenWindows
//

import SwiftUI

struct ContentView: View {
    @Environment(Dropbox.self) private var dropbox
    @Environment(\.openWindow) private var openWindow

    @State private var tokens: [Token] = Token.starterPack
    @State private var showUnderTheHood: Bool = false
    @State private var showAbout: Bool = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(tokens) { token in
                        TokenRow(token: token)
                            .draggable(token) {
                                TokenRow(token: token)
                                    .frame(width: 220)
                                    .padding(8)
                                    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
                            }
                    }
                } header: {
                    Text("Drag a token into the Drop Window")
                        .font(.subheadline)
                }
            }
            .navigationTitle("Source")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        openWindow(id: "drop")
                    } label: {
                        Label("Open Drop Window", systemImage: "rectangle.on.rectangle")
                    }
                }
                ToolbarItem(placement: .automatic) {
                    Menu {
                        Button("Under the Hood") { showUnderTheHood = true }
                        Button("About") { showAbout = true }
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
            .sheet(isPresented: $showUnderTheHood) { UnderTheHoodView() }
            .sheet(isPresented: $showAbout) { AboutView() }
        }
    }
}

struct TokenRow: View {
    let token: Token

    var body: some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(token.color)
                .frame(width: 36, height: 36)
                .overlay(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(.black.opacity(0.15), lineWidth: 1)
                )
            VStack(alignment: .leading) {
                Text(token.name)
                    .font(.body)
                Text(String(format: "hue %.2f", token.hue))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "line.3.horizontal")
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
    }
}

#Preview {
    ContentView()
        .environment(Dropbox())
}
