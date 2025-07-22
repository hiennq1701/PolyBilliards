package poly.billiards.dao.impl;

import java.sql.ResultSet;
import java.util.List;
import poly.billiards.dao.UserDAO;
import poly.billiards.entity.User;
import poly.billiards.util.XJdbc;
import poly.billiards.util.XQuery;

public class UserDAOImpl implements UserDAO {
    private static final String findAllSql = "SELECT * FROM Users";
    private static final String findByIdSql = "SELECT * FROM Users WHERE Username = ?";
    private static final String findByUsernameSql = "SELECT * FROM Users WHERE Username = ?";
    private static final String createSql = "INSERT INTO Users (Username, Password, Fullname, Email, Manager, Enabled, Photo) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String updateSql = "UPDATE Users SET Password = ?, Fullname = ?, Email = ?, Manager = ?, Enabled = ?, Photo = ? WHERE Username = ?";
    private static final String deleteByIdSql = "DELETE FROM Users WHERE Username = ?";
    
    @Override
    public List<User> findAll() {
        return XQuery.getBeanList(User.class, findAllSql);
    }
    
    @Override
    public User findById(String id) {
        return XQuery.getSingleBean(User.class, findByIdSql, id);
    }
    
    @Override
    public User findByUsername(String username) {
        return XQuery.getSingleBean(User.class, findByUsernameSql, username);
    }
    
    @Override
    public void create(User user) {
        XQuery.execute(createSql, 
            user.getUsername(),
            user.getPassword(),
            user.getFullname(),
            user.getEmail(),
            user.isManager(),
            user.isEnabled(),
            user.getPhoto()
        );
    }
    
    @Override
    public void update(User user) {
        XQuery.execute(updateSql,
            user.getPassword(),
            user.getFullname(),
            user.getEmail(),
            user.isManager(),
            user.isEnabled(),
            user.getPhoto(),
            user.getUsername()
        );
    }
    
    @Override
    public void deleteById(String id) {
        XQuery.execute(deleteByIdSql, id);
    }

    @Override
    public List<User> findByKeyword(String keyword) {
        List<User> list = new java.util.ArrayList<>();
        String sql = "SELECT * FROM Users WHERE Username LIKE ? OR Email LIKE ? OR Fullname LIKE ?";
        try (
            java.sql.Connection con = poly.billiards.util.XJdbc.getConnection();
            java.sql.PreparedStatement ps = con.prepareStatement(sql);
        ) {
            String kw = "%" + keyword + "%";
            ps.setString(1, kw);
            ps.setString(2, kw);
            ps.setString(3, kw);
            java.sql.ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("Username"));
                user.setPassword(rs.getString("Password"));
                user.setEmail(rs.getString("Email"));
                user.setFullname(rs.getString("Fullname"));
                user.setPhoto(rs.getString("Photo"));
                user.setManager(rs.getBoolean("Manager"));
                user.setEnabled(rs.getBoolean("Enabled"));
                list.add(user);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return list;
    }
}
