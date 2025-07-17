package poly.billiards.ui;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;
import javax.swing.JPanel;
import javax.swing.JButton;
import javax.swing.JTable;
import javax.swing.JDialog;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableRowSorter;
import poly.billiards.entity.User;
import poly.billiards.util.XExcel;
import poly.billiards.util.XDialog;
import poly.billiards.util.XValidation;
import poly.billiards.dao.UserDAO;
import poly.billiards.dao.impl.UserDAOImpl;

public class UserJPanel extends JPanel {

    private JTable table;
    private DefaultTableModel tableModel;
    private UserDAO dao;
    private List<User> users;
    private static final String[] COLUMN_NAMES = {
        "Username", "Họ tên", "Email", "Vai trò", "Trạng thái", "Ảnh"
    };

    public UserJPanel() {
        initComponents();
        fillTable();
    }

    private void initComponents() {
        // Initialize components
        tableModel = new DefaultTableModel(COLUMN_NAMES, 0) {
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };
        table = new JTable(tableModel);
        table.setRowSorter(new TableRowSorter<>(tableModel));
        dao = new UserDAOImpl();

        // Add components to the panel
        add(table);

        // Add buttons
        JButton btnExport = new JButton("Xuất dữ liệu");
        JButton btnImport = new JButton("Nhập dữ liệu");
        add(btnExport);
        add(btnImport);

        // Add action listeners
        btnExport.addActionListener(this::btnExportActionPerformed);
        btnImport.addActionListener(this::btnImportActionPerformed);
    }

    private void btnExportActionPerformed(java.awt.event.ActionEvent evt) {
        try {
            if (users == null || users.isEmpty()) {
                XDialog.alert(this, "Không có dữ liệu để xuất!");
                return;
            }
            XExcel.exportUsers(users);
            XDialog.info(this, "Xuất dữ liệu thành công!");
        } catch (IOException ex) {
            XDialog.alert(this, "Lỗi xuất dữ liệu: " + ex.getMessage());
        }
    }

    private void btnImportActionPerformed(java.awt.event.ActionEvent evt) {
        try {
            List<User> importedUsers = XExcel.importUsers();
            if (importedUsers.isEmpty()) {
                XDialog.alert(this, "Không có dữ liệu để nhập!");
                return;
            }

            List<String> errors = new ArrayList<>();
            int successCount = 0;

            for (User user : importedUsers) {
                try {
                    // Validate user data
                    if (!XValidation.isValidEmail(user.getEmail())) {
                        errors.add("Email không hợp lệ: " + user.getEmail());
                        continue;
                    }
                    dao.create(user);
                    successCount++;
                } catch (Exception e) {
                    errors.add("Lỗi khi thêm user " + user.getUsername() + ": " + e.getMessage());
                }
            }

            // Show results
            StringBuilder message = new StringBuilder();
            message.append("Nhập dữ liệu hoàn tất!\n");
            message.append("Thành công: ").append(successCount).append(" user\n");
            if (!errors.isEmpty()) {
                message.append("Lỗi:\n");
                errors.forEach(error -> message.append("- ").append(error).append("\n"));
            }
            XDialog.info(this, message.toString());
            
            this.fillTable();
        } catch (IOException ex) {
            XDialog.alert(this, "Lỗi nhập dữ liệu: " + ex.getMessage());
        }
    }

    private void fillTable() {
        users = dao.findAll();
        tableModel.setRowCount(0);
        for (User user : users) {
            Object[] row = {
                user.getUsername(),
                user.getFullname(),
                user.getEmail(),
                user.isManager() ? "Quản lý" : "Nhân viên",
                user.isEnabled() ? "Hoạt động" : "Khóa",
                user.getPhoto()
            };
            tableModel.addRow(row);
        }
    }
} 
