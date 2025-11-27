import { useAppState } from "@/hooks/useAppState";
import SharedUserDefaultsModule from "@/modules/shared-user-defaults/src/SharedUserDefaultsModule";
import WidgetRefreshModule from "@/modules/widget-refresh/src/WidgetRefreshModule";
import React, { useEffect, useState } from "react";
import {
  Modal,
  ScrollView,
  StyleSheet,
  Text,
  TouchableOpacity,
  View,
} from "react-native";

export default function LocationDropdown() {
  const [selectedLocation, setSelectedLocation] = useState("");
  const [isOpen, setIsOpen] = useState(false);

  const appState = useAppState();

  useEffect(() => {
    if (appState === "active") {
      (async () => {
        try {
          const location =
            await SharedUserDefaultsModule.getDataFromSharedUserDefaults(
              "location"
            );
          setSelectedLocation(location || "");
        } catch (error) {
          return error;
        }
      })();
    }
  }, [appState]);

  const ukLocations = [
    "London",
    "Manchester",
    "Birmingham",
    "Edinburgh",
    "Glasgow",
    "Liverpool",
    "Bristol",
    "Leeds",
    "Cardiff",
    "Newcastle",
    "Belfast",
    "Oxford",
    "Cambridge",
  ];

  const handleSelect = async (location: string) => {
    setSelectedLocation(location);
    await SharedUserDefaultsModule.setDataInSharedUserDefaults(
      location,
      "location"
    );
    await WidgetRefreshModule.reloadAllTimelines();
    setIsOpen(false);
  };

  return (
    <View style={styles.container}>
      <View style={styles.card}>
        <Text style={styles.title}>Select Location</Text>

        <TouchableOpacity
          style={styles.dropdown}
          onPress={() => setIsOpen(true)}
        >
          <Text
            style={selectedLocation ? styles.selectedValue : styles.placeholder}
          >
            {selectedLocation || "Choose a location..."}
          </Text>
          <Text style={styles.arrow}>▼</Text>
        </TouchableOpacity>

        <Modal
          visible={isOpen}
          transparent={true}
          animationType="fade"
          onRequestClose={() => setIsOpen(false)}
        >
          <TouchableOpacity
            style={styles.modalOverlay}
            activeOpacity={1}
            onPress={() => setIsOpen(false)}
          >
            <View style={styles.modalContent}>
              <ScrollView>
                {ukLocations.map((location) => (
                  <TouchableOpacity
                    key={location}
                    style={styles.option}
                    onPress={() => handleSelect(location)}
                  >
                    <Text style={styles.optionText}>{location}</Text>
                  </TouchableOpacity>
                ))}
              </ScrollView>
            </View>
          </TouchableOpacity>
        </Modal>

        {selectedLocation !== "" && (
          <View style={styles.selectedContainer}>
            <Text style={styles.selectedLabel}>Selected:</Text>
            <Text style={styles.selectedText}>{selectedLocation}</Text>
          </View>
        )}
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: "#f3f4f6",
    alignItems: "center",
    justifyContent: "center",
  },
  card: {
    backgroundColor: "white",
    padding: 24,
    borderRadius: 12,
    width: 320,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 5,
  },
  title: {
    fontSize: 24,
    fontWeight: "bold",
    color: "#1f2937",
    marginBottom: 16,
  },
  dropdown: {
    flexDirection: "row",
    justifyContent: "space-between",
    alignItems: "center",
    borderWidth: 1,
    borderColor: "#d1d5db",
    borderRadius: 8,
    padding: 12,
    backgroundColor: "white",
  },
  placeholder: {
    fontSize: 16,
    color: "#9ca3af",
  },
  selectedValue: {
    fontSize: 16,
    color: "#1f2937",
  },
  arrow: {
    fontSize: 12,
    color: "#6b7280",
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: "rgba(0, 0, 0, 0.5)",
    justifyContent: "center",
    alignItems: "center",
  },
  modalContent: {
    backgroundColor: "white",
    borderRadius: 12,
    width: 280,
    maxHeight: 400,
    shadowColor: "#000",
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 4,
    elevation: 5,
  },
  option: {
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: "#f3f4f6",
  },
  optionText: {
    fontSize: 16,
    color: "#1f2937",
  },
  selectedContainer: {
    marginTop: 16,
    padding: 16,
    backgroundColor: "#eff6ff",
    borderRadius: 8,
  },
  selectedLabel: {
    fontSize: 12,
    color: "#6b7280",
    marginBottom: 4,
  },
  selectedText: {
    fontSize: 18,
    fontWeight: "600",
    color: "#2563eb",
  },
});
