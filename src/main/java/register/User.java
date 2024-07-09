package register;

import lombok.Data;

@Data
public class User {
    String username;
    String password;
    String email;
    String salt; 
}
