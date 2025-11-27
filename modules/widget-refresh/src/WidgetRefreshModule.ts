import { NativeModule, requireNativeModule } from "expo";

import { WidgetRefreshModuleEvents } from "./WidgetRefresh.types";

declare class WidgetRefreshModule extends NativeModule<WidgetRefreshModuleEvents> {
  reloadAllTimelines(): Promise<void>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<WidgetRefreshModule>("WidgetRefresh");
