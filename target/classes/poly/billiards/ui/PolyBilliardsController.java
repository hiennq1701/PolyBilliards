package poly.billiards.ui;

import javax.swing.JDialog;
import javax.swing.JFrame;
import poly.billiards.ui.manager.*;
import poly.billiards.util.XDialog;

public interface PolyBilliardsController {
    void init();
    
    default void exit() {
        if (XDialog.confirm((java.awt.Component) this, "Bạn muốn kết thúc?")) {
            System.exit(0);
        }
    }
    
    default void showJDialog(JDialog dialog) {
        dialog.setLocationRelativeTo(null);
        dialog.setVisible(true);
    }
    
    default void showWelcomeJDialog(JFrame frame) {
        this.showJDialog(new WelcomeJDialog(frame, true));
    }
    
    default void showLoginJDialog(JDialog dialog) {
        this.showJDialog(new LoginJDialog(dialog, true));
    }
//    default void showRevenueManagerJDialog(JDialog dialog) {
//        this.showJDialog(new RevenueManagerJDialog(dialog, true));
//    }
    
    default void showChangePasswordJDialog(JFrame frame) {
        this.showJDialog(new ChangePasswordJDialog(frame, true));
    }
    
    default void showUserManagerJDialog(JFrame frame) {
        this.showJDialog(new UserManagerJDialog(frame, true));
    }
    
    default void showHistoryJDialog(JFrame frame) {
        this.showJDialog(new BillHistoryJDialog((PolyBilliardsJFrame) frame, true));
    }
    
    default void showDrinkManagerJDialog(JFrame frame) {
        this.showJDialog(new FoodManagerJDialog(frame, true));
    }
    
    default void showCategoryManagerJDialog(JFrame frame) {
        this.showJDialog(new FoodCategoryManagerJDialog(frame, true));
    }
    
//    default void showCardManagerJDialog(JFrame frame) {
//        this.showJDialog(new CardManagerJDialog(frame, true));
//    }
    
//    default void showBillManagerJDialog(JFrame frame) {
//        this.showJDialog(new BillManagerJDialog(frame, true));
//    }
    default void showActivityHistoryJDialog(JDialog dialog) {
        this.showJDialog(new ActivityHistoryJDialog(dialog, true, null)); // Pass null or currentUser as needed
    }
}
