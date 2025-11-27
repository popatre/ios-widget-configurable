import { NativeModule, requireNativeModule } from "expo";

import { SharedUserDefaultsModuleEvents } from "./SharedUserDefaults.types";

declare class SharedUserDefaultsModule extends NativeModule<SharedUserDefaultsModuleEvents> {
  setDataInSharedUserDefaults(value: string, key: string): Promise<void>;
  getDataFromSharedUserDefaults(key: string): Promise<string | null>;
  removeDataFromSharedUserDefaults(key: string): Promise<void>;
}

// This call loads the native module object from the JSI.
export default requireNativeModule<SharedUserDefaultsModule>(
  "SharedUserDefaults"
);
