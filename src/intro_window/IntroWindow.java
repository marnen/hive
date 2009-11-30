/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*
 * IntroWindow.java
 *
 * Created on Nov 29, 2009, 9:48:12 PM
 */

package intro_window;

import org.marnen.hive.ViewUtilities;

/**
 *
 * @author marnen
 */
public class IntroWindow extends javax.swing.JFrame {

  /** Creates new form IntroWindow */
  public IntroWindow() {
      initComponents();
  }

  /** This method is called from within the constructor to
   * initialize the form.
   * WARNING: Do NOT modify this code. The content of this method is
   * always regenerated by the Form Editor.
   */
  @SuppressWarnings("unchecked")
  // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
  private void initComponents() {

    jLabel1 = new javax.swing.JLabel();
    menu_bar = new javax.swing.JMenuBar();

    setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
    java.util.ResourceBundle bundle = java.util.ResourceBundle.getBundle("intro_window/Bundle"); // NOI18N
    setTitle(bundle.getString("appName")); // NOI18N

    jLabel1.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
    jLabel1.setText(bundle.getString("welcome")); // NOI18N
    setJMenuBar(menu_bar);

    javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
    getContentPane().setLayout(layout);
    layout.setHorizontalGroup(
      layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(layout.createSequentialGroup()
        .addContainerGap()
        .addComponent(jLabel1, javax.swing.GroupLayout.DEFAULT_SIZE, 174, Short.MAX_VALUE)
        .addContainerGap())
    );
    layout.setVerticalGroup(
      layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(layout.createSequentialGroup()
        .addContainerGap()
        .addComponent(jLabel1)
        .addContainerGap(32, Short.MAX_VALUE))
    );

    pack();
  }// </editor-fold>//GEN-END:initComponents

    /**
    * @param args the command line arguments
    */
    public static void main(String args[]) {
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new IntroWindow().setVisible(true);
            }
        });
    }


  // Variables declaration - do not modify//GEN-BEGIN:variables
  private javax.swing.JLabel jLabel1;
  private javax.swing.JMenuBar menu_bar;
  // End of variables declaration//GEN-END:variables

}
