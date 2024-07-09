package register;

public interface UserDao {
    int register(User user);
    User findByUsername(String username);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);
}
