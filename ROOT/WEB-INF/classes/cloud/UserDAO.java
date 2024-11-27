package cloud;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    // CREATE
    public void createUser(User user) throws SQLException {
        String sql = "INSERT INTO user (name, userId, password, email, birth, nickname, phone, isMember, isAdmin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)"; 
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getUserId());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getBirth());
            pstmt.setString(6, user.getNickname());
            pstmt.setString(7, user.getPhone());
            pstmt.setBoolean(8, user.getMember());
            pstmt.setBoolean(9, user.getAdmin());
            pstmt.executeUpdate();
        }
    }

    // READ (모든 사용자 조회)
    public List<User> getAllUsers() throws SQLException {
        String sql = "SELECT * FROM user";
        List<User> users = new ArrayList<>();
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setUserId(rs.getString("userId"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setBirth(rs.getString("birth"));
                user.setNickname(rs.getString("nickname"));
                user.setPhone(rs.getString("phone"));
                user.setMember(rs.getBoolean("isMember"));
                user.setAdmin(rs.getBoolean("isAdmin"));
                users.add(user);
            }
        }
        return users;
    }

    // READ (특정 사용자 조회)
    public User getUserById(int id) throws SQLException {
        String sql = "SELECT * FROM user WHERE id = ?";
        User user = null;
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setUserId(rs.getString("userId"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    user.setBirth(rs.getString("birth"));
                    user.setNickname(rs.getString("nickname"));
                    user.setPhone(rs.getString("phone"));
                    user.setMember(rs.getBoolean("isMember"));
                    user.setAdmin(rs.getBoolean("isAdmin"));
                }
            }
        }
        return user;
    }

    // READ (특정 사용자 id 조회)
    public User getUserByUserId(String userId) throws SQLException {
        String sql = "SELECT * FROM user WHERE userId = ?";
        User user = null;
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setUserId(rs.getString("userId"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    user.setBirth(rs.getString("birth"));
                    user.setNickname(rs.getString("nickname"));
                    user.setPhone(rs.getString("phone"));
                    user.setMember(rs.getBoolean("isMember"));
                    user.setAdmin(rs.getBoolean("isAdmin"));
                }
            }
        }
        return user;
    }

    // 아이디 중복 여부
    public boolean isUserIdExists(String userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM user WHERE userId = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0; // 중복 아이디가 있으면 true 반환
                }
            }
        }
        return false; // 중복 아이디 없음
    }

    // UPDATE
    public void updateUser(User user) throws SQLException {
        String sql = "UPDATE user SET name = ?, userId = ?, password = ?, email = ?, birth = ?, nickname = ?, phone = ?, isMember = ?, isAdmin = ? WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getUserId());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getBirth());
            pstmt.setString(6, user.getNickname());
            pstmt.setString(7, user.getPhone());
            pstmt.setBoolean(8, user.getMember());
            pstmt.setBoolean(9, user.getAdmin());
            pstmt.setInt(10, user.getId());
            pstmt.executeUpdate();
        }
    }

    // DELETE
    public void deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM user WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
    }

    // 추가: 페이지네이션 지원
    public List<User> getUsers(int page, int pageSize) throws SQLException {
        String sql = "SELECT * FROM user LIMIT ?, ?";
        List<User> users = new ArrayList<>();
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, (page - 1) * pageSize); // OFFSET
            pstmt.setInt(2, pageSize); // LIMIT
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setUserId(rs.getString("userId"));
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    user.setBirth(rs.getString("birth"));
                    user.setNickname(rs.getString("nickname"));
                    user.setPhone(rs.getString("phone"));
                    user.setMember(rs.getBoolean("isMember"));
                    user.setAdmin(rs.getBoolean("isAdmin"));
                    users.add(user);
                }
            }
        }
        return users;
    }

    // 추가: 전체 사용자 수
    public int getTotalUsers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM user";
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // TODO isUserIdExists 메서드 참고하여
    // 1. isAdmin인지 가져오기
    // 2. isMember인지 가져오기
    // 추가적으로 세션에다가 그런 정보는 잘 안넣어두긴함 ㅋㅋ <= 해킹 위협, 탈취
}
