//
//  configurable_widgetBundle.swift
//  configurable-widget
//
//  Created by Jonathan McGuire on 25/11/2025.
//

import WidgetKit
import SwiftUI

@main
struct configurable_widgetBundle: WidgetBundle {
    var body: some Widget {
        configurable_widget()
        configurable_widgetControl()
        configurable_widgetLiveActivity()
    }
}
