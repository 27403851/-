package register;

public interface UserService {

	int register(String username,String password, String email);
	boolean login(String username, String password);
	User findByUsername(String username);
}
