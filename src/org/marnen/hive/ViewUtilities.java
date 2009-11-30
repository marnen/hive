package org.marnen.hive;

/**
 * This class contains common methods for the various views in the application.
 * @author marnen
 */

public class ViewUtilities {
  /**
   * Creates a shortcut key with the default modifier (Cmd on Mac OS, Ctrl in most other places)
   * @param key the VK_* keycode of the shortcut key
   */
  public static javax.swing.KeyStroke makeShortcut(int key) {
    return javax.swing.KeyStroke.getKeyStroke(key, java.awt.Toolkit.getDefaultToolkit().getMenuShortcutKeyMask());
  }
}
