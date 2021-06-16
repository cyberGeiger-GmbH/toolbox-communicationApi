package mocks;

import eu.cybergeiger.communication.GeigerUrl;
import eu.cybergeiger.communication.Message;
import eu.cybergeiger.communication.PluginListener;
import java.util.ArrayList;

/**
 * A Pluginlistener for test purposes that allows to get all messages received.
 */
public class SimpleEventListener implements PluginListener {

  ArrayList<Message> events;

  public SimpleEventListener() {
    this.events = new ArrayList<>();
  }

  @Override
  public void pluginEvent(GeigerUrl url, Message msg) {
    events.add(msg);
  }

  public ArrayList<Message> getEvents() {
    return new ArrayList<>(events);
  }

}
