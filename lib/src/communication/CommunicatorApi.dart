import 'package:localstorage/localstorage.dart';

import 'GeigerUrl.dart';
import 'MenuItem.dart';
import 'MenuRegistrar.dart';
import 'Message.dart';
import 'MessageType.dart';
import 'PluginListener.dart';
import 'PluginRegistrar.dart';

/// The API provided by all communicator interfaces.
abstract class CommunicatorApi with PluginRegistrar, MenuRegistrar {
  /// Activates the plugin and sets up communication on the specified [port].
  void activatePlugin(int port);

  /// Deactivates the plugin and makes sure that a plugin is started immediately if contacted.
  ///
  /// If a plugin is properly deactivated no timeout is reached before contacting a plugin.
  void deactivatePlugin();

  /// Obtain controller to access the storage.
  ///
  /// Throws StorageException in case allocation of storage backed fails
  StorageController? getStorage();

  /// Register a [listener] for specific [events] on the Master.
  ///
  /// Use [MessageType.ALL_EVENTS] to register for all messages.
  void registerListener(List<MessageType> events, PluginListener listener);

  /// Remove a [listener] waiting for [events].
  ///
  /// Specify `null` for [events] to remove the listener from all events.
  void deregisterListener(List<MessageType>? events, PluginListener listener);

  /// Sends a custom, plugin-specific [message] to a peer plugin with the id [pluginId].
  ///
  /// Mainly used for internal purposes. Plugins may only send messages to the toolbox core.
  void sendMessage(String pluginId, Message message);

  /// Notify plugin about a menu entry with a specific [url] being pressed.
  ///
  /// Wrapper function used by UI to notify plugins about pressed buttons/menu entries.
  void menuPressed(GeigerUrl url);

  /// Returns the list of currently registered menu.
  ///
  /// This call is for the toolbox core only.
  List<MenuItem> getMenuList();

  /// Notify all plugins about the event that a scan button has been pressed.
  ///
  /// This call is for the toolbox core only.
  void scanButtonPressed();
}
