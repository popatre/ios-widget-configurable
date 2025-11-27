//
//  configurable_widgetLiveActivity.swift
//  configurable-widget
//
//  Created by Jonathan McGuire on 25/11/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct configurable_widgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct configurable_widgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: configurable_widgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension configurable_widgetAttributes {
    fileprivate static var preview: configurable_widgetAttributes {
        configurable_widgetAttributes(name: "World")
    }
}

extension configurable_widgetAttributes.ContentState {
    fileprivate static var smiley: configurable_widgetAttributes.ContentState {
        configurable_widgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: configurable_widgetAttributes.ContentState {
         configurable_widgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: configurable_widgetAttributes.preview) {
   configurable_widgetLiveActivity()
} contentStates: {
    configurable_widgetAttributes.ContentState.smiley
    configurable_widgetAttributes.ContentState.starEyes
}
