package poly.billiards.dao;

import java.util.List;
import poly.billiards.entity.User;

public interface UserDAO {
    List<User> findAll();
    User findById(String id);
    User findByUsername(String username);
    void create(User user);
    void update(User user);
    void deleteById(String id);
}
