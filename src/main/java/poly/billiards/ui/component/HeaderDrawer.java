package poly.billiards.ui.component;

import poly.billiards.entity.User;
import javax.swing.ImageIcon;

public class HeaderDrawer extends javax.swing.JPanel {

    private User currentUser;

    public HeaderDrawer() {
        initComponents();
    }

    public HeaderDrawer(User currentUser) {
        this.currentUser = currentUser;
        initComponents();
        updateUserInfo();
    }

    private void updateUserInfo() {
        if (currentUser != null) {
            lblFullname.setText(currentUser.getFullname());
            
            // Cập nhật email từ currentUser
            String userEmail = currentUser.getEmail();
            if (userEmail != null && !userEmail.isEmpty()) {
                txtEmail.setText(userEmail);
                System.out.println("User email loaded: " + userEmail);
            } else {
                txtEmail.setText("No email available");
                System.out.println("No email available for user");
            }
            
            // Cập nhật avatar từ user photo
            String photoPath = currentUser.getPhoto();
            if (photoPath != null && !photoPath.isEmpty()) {
                try {
                    // Load từ filesystem thay vì classpath
                    java.io.File photoFile = new java.io.File("photos/" + photoPath);
                    if (photoFile.exists()) {
                        ImageIcon userAvatar = new ImageIcon(photoFile.getAbsolutePath());
                        imageAvatar1.setImage(userAvatar);
                        System.out.println("Avatar loaded successfully: " + photoFile.getAbsolutePath());
                    } else {
                        throw new Exception("Photo file not found: " + photoFile.getAbsolutePath());
                    }
                } catch (Exception e) {
                    System.err.println("Error loading user avatar: " + e.getMessage());
                    // Fallback to default avatar
                    try {
                        ImageIcon defaultAvatar = new ImageIcon(getClass().getResource("/poly/billiards/icons/Logo2.png"));
                        imageAvatar1.setImage(defaultAvatar);
                        System.out.println("Default avatar loaded");
                    } catch (Exception e2) {
                        System.err.println("Error loading default avatar: " + e2.getMessage());
                    }
                }
            } else {
                System.out.println("No photo path, using default avatar");
                try {
                    ImageIcon defaultAvatar = new ImageIcon(getClass().getResource("/poly/billiards/icons/Logo2.png"));
                    imageAvatar1.setImage(defaultAvatar);
                } catch (Exception e) {
                    System.err.println("Error loading default avatar: " + e.getMessage());
                }
            }
        }
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        imageAvatar1 = new poly.billiards.ui.component.ImageAvatarDrawer();
        lblFullname = new javax.swing.JLabel();
        txtEmail = new javax.swing.JLabel();

        setBackground(new java.awt.Color(0, 102, 204));

        imageAvatar1.setBorderSize(3);
        imageAvatar1.setBorderSpace(2);
        imageAvatar1.setGradientColor1(new java.awt.Color(255, 0, 0));
        imageAvatar1.setGradientColor2(new java.awt.Color(27, 0, 255));
        imageAvatar1.setImage(new javax.swing.ImageIcon(getClass().getResource("/icon/logo.jpg"))); // NOI18N

        lblFullname.setFont(new java.awt.Font("Segoe UI Black", 1, 15)); // NOI18N
        lblFullname.setForeground(new java.awt.Color(255, 255, 255));
        lblFullname.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        lblFullname.setText("Javaswingdev.com");

        txtEmail.setFont(new java.awt.Font("sansserif", 0, 14)); // NOI18N
        txtEmail.setForeground(new java.awt.Color(255, 255, 255));
        txtEmail.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        txtEmail.setText("+855 9998881001");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(lblFullname, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(imageAvatar1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(txtEmail, javax.swing.GroupLayout.DEFAULT_SIZE, 274, Short.MAX_VALUE))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(20, 20, 20)
                .addComponent(imageAvatar1, javax.swing.GroupLayout.PREFERRED_SIZE, 85, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(lblFullname)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(txtEmail)
                .addContainerGap())
        );
    }// </editor-fold>//GEN-END:initComponents

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private poly.billiards.ui.component.ImageAvatarDrawer imageAvatar1;
    private javax.swing.JLabel lblFullname;
    private javax.swing.JLabel txtEmail;
    // End of variables declaration//GEN-END:variables
}
