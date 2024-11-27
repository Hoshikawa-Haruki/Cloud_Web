package cloud;
public class User {
    private int id;
    private String name;
    private String userId;
    private String password;
    private String email;
    private String birth;
    private String nickname;
    private String phone;
    private boolean isMember;
    private boolean isAdmin;

    // Getter와 Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getBirth() { return birth; }
    public void setBirth(String birth) { this.birth = birth; }

    public String getNickname() { return nickname; }
    public void setNickname(String nickname) { this.nickname = nickname; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public boolean getMember() { return isMember; }
    public void setMember(boolean isMember) { this.isMember = isMember; }

    public boolean getAdmin() { return isAdmin; }
    public void setAdmin(boolean isAdmin) { this.isAdmin = isAdmin; }
    
}
