package poly.billiards.util;

import java.awt.Component;
import javax.swing.JOptionPane;

public class XDialog {

    public static void alert(Component parent, String message){
        JOptionPane.showMessageDialog(parent, message, "Cảnh báo!", JOptionPane.ERROR_MESSAGE);
    }
    
    public static void info(Component parent, String message){
        JOptionPane.showMessageDialog(parent, message, "Thông báo!", JOptionPane.INFORMATION_MESSAGE);
    }
    
    public static boolean confirm(Component parent, String message) {
        int result = JOptionPane.showConfirmDialog(parent, message, "Xác nhận", JOptionPane.YES_NO_OPTION,
                JOptionPane.QUESTION_MESSAGE);
        return result == JOptionPane.YES_OPTION;
    }

    public static String prompt(Component parent, String message){
        return JOptionPane.showInputDialog(parent, message, "Nhập vào", JOptionPane.INFORMATION_MESSAGE);
    }
}
