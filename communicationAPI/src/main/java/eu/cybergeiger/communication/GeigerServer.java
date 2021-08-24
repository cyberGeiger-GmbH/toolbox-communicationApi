package eu.cybergeiger.communication;

import ch.fhnw.geiger.totalcross.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import totalcross.net.ServerSocket;
import totalcross.net.Socket;
import totalcross.util.concurrent.ThreadPool;

/**
 * Communicator for Geiger Core.
 */
public class GeigerServer extends GeigerCommunicator {
  // TODO find a way to get number of cores
  //private final ThreadPool executor = new ThreadPool(4);
  private static final int port = 1234;
  private ServerSocket serverSocket;
  private final LocalApi localApi;
  Thread server;
  boolean shutdown;

  public GeigerServer(LocalApi api) {
    this.localApi = api;
  }

  /**
   * Start the GeigerServer.
   *
   * @throws IOException if server could not be started
   */
  public void start() throws IOException {
    // TODO handle shutdown correctly even when JVM close
    shutdown = false;
    server = new Thread(() -> {
      try {
        serverSocket = new ServerSocket(port);

        while (!shutdown) {
          final Socket s = serverSocket.accept();
          // This is only for debugging purposes use lambda for production

          System.out.println("## GEIGER-Server run method reached");
          (new MessageHandler(s, localApi)).run();
          //executor.execute(() -> new MessageHandler(s, localApi));
        }
      } catch (IOException e) {
        // TODO error handling
        e.printStackTrace();
      }
    });
    server.setName("GeigerServer");
    server.start();
  }

  /**
   * Stop the GeigerServer.
   *
   * @throws IOException if server could not be closed
   */
  public void stop() throws IOException {
    // TODO server stop
    shutdown = true;
    Socket s = new Socket("127.0.0.1", port);
    s.close();
  }

  @Override
  public int getPort() {
    return port;
  }

  public static int getDefaultPort() {
    return port;
  }

  @Override
  public void sendMessage(PluginInformation pluginInformation, Message msg) {
    try {
      Socket s = new Socket("127.0.0.1", pluginInformation.getPort());

      OutputStream out = s.asOutputStream();
      ByteArrayOutputStream bos = new ByteArrayOutputStream();
      msg.toByteArrayStream(bos);
      out.write(bos.toByteArray());

      out.close();
      //s.close();
    } catch (IOException e) {
      // TODO if plugin unknown then try to start the plugin and resend message
      e.printStackTrace();
    }
  }

  @Override
  public void startPlugin(PluginInformation pluginInformation) {
    // TODO check how this behaves on different operating systems
    // For android the executable should be the classname of the plugin (which usually is also used
    // for intents)
    // It is the responsibility of the plugin to send the correct string/path according to the
    // current operating system
    //Vm.exec(pluginInformation.getExecutable(), null, 0, true);
  }
}
