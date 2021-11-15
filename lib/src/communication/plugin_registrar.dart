library geiger_api;

abstract class PluginRegistrar {
  /// Registers the plugin to the toolbox framework.
  ///
  /// Throws [CommunicationException] if registering in the master plugin failed.
  Future<void> registerPlugin();

  /// Unregisters an already registered plugin in the toolbox.
  ///
  /// Throws [CommunicationException] if the provided id is not available in the current auth database.
  Future<void> deregisterPlugin();
}
