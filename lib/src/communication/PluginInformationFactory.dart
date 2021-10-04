import 'dart:collection';

import 'CommunicationSecret.dart';
import 'PluginInformation.dart';

/// A factory class to create plugin information entries.
class PluginInformationFactory {
  static final Map<String, PluginInformation> store = HashMap();

  /// Retrieves plugin information for the plugin with the [id].
  ///
  /// Additional [PluginInformation] properties can be passed to create an
  /// instance in-case it doesn't exist.
  static PluginInformation? getPluginInformation(String id,
      [String? executor, int? port, CommunicationSecret? secret]) {
    if (executor == null || port == null || secret == null) {
      return store[id.toLowerCase()];
    }

    var info = store[id.toLowerCase()];
    if (info == null) {
      info = PluginInformation(executor, port, secret);
      setPluginInformation(id, info);
    }
    return info;
  }

  /// Puts [info] corresponding to the plugin with [id] into the store.
  ///
  /// Returns the previously set information or null if its new.
  static PluginInformation? setPluginInformation(
      String id, PluginInformation info) {
    var old = getPluginInformation(id);
    store[id.toLowerCase()] = info;
    return old;
  }

  /// Clears all plugin information from the store.
  static void zap() {
    store.clear();
  }
}
