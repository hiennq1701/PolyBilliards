package poly.billiards.ui;

import javax.swing.JDialog;
import poly.billiards.util.XDialog;

public interface LoginController {
    void init();
    void open();
    void login();
    
    default void exit() {
        if (XDialog.confirm((java.awt.Component) this, "Bạn muốn kết thúc?")) {
            System.exit(0);
        }
    }
    
    default void showJDialog(JDialog dialog) {
        dialog.setLocationRelativeTo(null);
        dialog.setVisible(true);
    }
}
