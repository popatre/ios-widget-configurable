//
//  configurable_widget.swift
//  configurable-widget
//
//  Created by Jonathan McGuire on 25/11/2025.
//

import WidgetKit
import SwiftUI

struct Globals {
    static var appGroudId = "group.com.jmac.ConfigWidget"
}

func getSharedString(forKey key: String, defaultValue: String = "") -> String {
    let appGroupID = Globals.appGroudId
    let sharedDefaults = UserDefaults(suiteName: appGroupID)
    return sharedDefaults?.string(forKey: key) ?? defaultValue
}

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
      SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), location:"Manchester")
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
      SimpleEntry(date: Date(), configuration: configuration, location:"Manchester")
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let location = getSharedString(forKey: "location")
      
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
          let entry = SimpleEntry(date: entryDate, configuration: configuration, location:location)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }

//    func relevances() async -> WidgetRelevances<ConfigurationAppIntent> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let location:String
}

struct configurable_widgetEntryView : View {
    var entry: Provider.Entry

  var body: some View {
      VStack(spacing: 2) {

          
          VStack(spacing: 1) {
              Text("Time:")
                  .font(.headline)

              Text(entry.date, style: .time)
                  .font(.title3)
          }
         
          VStack(spacing: 4) {
              Text("App state:")
              .font(.caption2)

              Text(entry.location)
                  .font(.subheadline)
          }
          .padding(.vertical, 3)
          .padding(.horizontal,6)
          .background(
              RoundedRectangle(cornerRadius: 12)
                  .fill(Color.indigo.opacity(0.85))
          )
          .foregroundStyle(.white)
          .shadow(radius: 3)

        Divider()
          VStack(spacing: 3) {
              Text("Widget state:")
              .font(.caption2)
                  .foregroundStyle(.white)

              Text(entry.configuration.selectedCity.rawValue)
                  .foregroundStyle(.white)
                  .font(.subheadline)
          }
          .padding(.vertical, 2)
          .padding(.horizontal, 12)
        
          .background(
              RoundedRectangle(cornerRadius: 12)
                  .fill(Color.cyan)
          )
          .shadow(radius: 3)
      }
      .padding()
  }

}

struct configurable_widget: Widget {
    let kind: String = "configurable_widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            configurable_widgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
      intent.selectedCity = .london
//      intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
      intent.selectedCity = .manchester
//      intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    configurable_widget()
} timeline: {
  SimpleEntry(date: .now, configuration: .smiley, location: "Manchester")
  SimpleEntry(date: .now, configuration: .starEyes, location: "Manchester")
}

#Preview(as: .systemMedium) {
    configurable_widget()
} timeline: {
  SimpleEntry(date: .now, configuration: .smiley, location: "Manchester")
}

#Preview(as: .systemLarge) {
    configurable_widget()
} timeline: {
  SimpleEntry(date: .now, configuration: .smiley, location: "Manchester")
}
