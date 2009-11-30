/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package file_menu;

import org.marnen.hive.*;

/**
 * Bean representing a standard, reusable File menu.
 * @author marnen
 */
public class FileMenu extends javax.swing.JMenu {
  private javax.swing.JMenuItem file_new_menu_item;
  private javax.swing.JMenuItem file_open_menu_item;

  public FileMenu() {
    initComponents();
  }

  private void initComponents() {
    file_new_menu_item = new javax.swing.JMenuItem();
    file_open_menu_item = new javax.swing.JMenuItem();

    // TODO: Move bundle file to a more appropriate place.
    java.util.ResourceBundle bundle = java.util.ResourceBundle.getBundle("file_menu/Bundle"); // NOI18N
    setLabel(bundle.getString("FileMenu.text")); // NOI18N

    file_new_menu_item.setAccelerator(ViewUtilities.makeShortcut(java.awt.event.KeyEvent.VK_N));
    file_new_menu_item.setText(bundle.getString("FileMenu.New")); // NOI18N
    add(file_new_menu_item);

    file_open_menu_item.setAccelerator(ViewUtilities.makeShortcut(java.awt.event.KeyEvent.VK_O));
    file_open_menu_item.setText(bundle.getString("FileMenu.Open")); // NOI18N
    add(file_open_menu_item);
  }
}
