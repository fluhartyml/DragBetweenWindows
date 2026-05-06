//
//  Token.swift
//  DragBetweenWindows
//

import SwiftUI
import UniformTypeIdentifiers
import CoreTransferable

struct Token: Identifiable, Hashable, Codable, Transferable {
    let id: UUID
    var name: String
    var hue: Double

    init(id: UUID = UUID(), name: String, hue: Double) {
        self.id = id
        self.name = name
        self.hue = hue
    }

    var color: Color {
        Color(hue: hue, saturation: 0.7, brightness: 0.95)
    }

    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .dragBetweenWindowsToken)
    }

    static let starterPack: [Token] = [
        Token(name: "Crimson",   hue: 0.00),
        Token(name: "Amber",     hue: 0.10),
        Token(name: "Goldenrod", hue: 0.13),
        Token(name: "Olive",     hue: 0.22),
        Token(name: "Forest",    hue: 0.34),
        Token(name: "Teal",      hue: 0.48),
        Token(name: "Sky",       hue: 0.55),
        Token(name: "Indigo",    hue: 0.68),
        Token(name: "Violet",    hue: 0.78),
        Token(name: "Magenta",   hue: 0.88)
    ]
}

extension UTType {
    static let dragBetweenWindowsToken = UTType(exportedAs: "me.fluharty.DragBetweenWindows.token")
}

@Observable
final class Dropbox {
    var dropped: [Token] = []

    func accept(_ token: Token) {
        guard !dropped.contains(token) else { return }
        dropped.append(token)
    }

    func clear() {
        dropped.removeAll()
    }
}
