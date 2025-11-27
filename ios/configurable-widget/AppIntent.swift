//
//  AppIntent.swift
//  configurable-widget
//
//  Created by Jonathan McGuire on 25/11/2025.
//

import WidgetKit
import AppIntents

enum City: String, AppEnum {
    case london = "London"
    case manchester = "Manchester"
    case birmingham = "Birmingham"
    case edinburgh = "Edinburgh"
    case glasgow = "Glasgow"
    case liverpool = "Liverpool"
    case bristol = "Bristol"
    case leeds = "Leeds"
    case cardiff = "Cardiff"
    case newcastle = "Newcastle"
    case belfast = "Belfast"
    case oxford = "Oxford"
    case cambridge = "Cambridge"
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation = "City"
    
    static var caseDisplayRepresentations: [City: DisplayRepresentation] = [
        .london: "London",
        .manchester: "Manchester",
        .birmingham: "Birmingham",
        .edinburgh: "Edinburgh",
        .glasgow: "Glasgow",
        .liverpool: "Liverpool",
        .bristol: "Bristol",
        .leeds: "Leeds",
        .cardiff: "Cardiff",
        .newcastle: "Newcastle",
        .belfast: "Belfast",
        .oxford: "Oxford",
        .cambridge: "Cambridge"
    ]
}

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("Configure your location")

    @Parameter(title: "Location", default: .manchester)
    var selectedCity: City
    
//    @Parameter(title: "Favorite Emoji")
//    var favoriteEmoji: String?
}
