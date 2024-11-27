package cloud;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDAO {
    private Connection conn;

    public PostDAO(Connection conn) {
        this.conn = conn;
    }

    // CREATE
    public void createPost(Post post) throws SQLException {
        String sql = "INSERT INTO post (title, content, user, createdAt) VALUES (?, ?, ?, NOW())";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getContent());
            pstmt.setString(3, post.getUser());
            pstmt.executeUpdate();
        }
    }

    // READ (모든 게시글 조회)
    public List<Post> getAllPosts() throws SQLException {
        String sql = "SELECT * FROM post";
        List<Post> posts = new ArrayList<>();
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Post post = new Post();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setContent(rs.getString("content"));
                post.setUser(rs.getString("user"));
                post.setCreatedAt(rs.getString("createdAt"));
                posts.add(post);
            }
        }
        return posts;
    }

    // READ (특정 게시글 조회)
    public Post getPostById(int id) throws SQLException {
        String sql = "SELECT * FROM post WHERE id = ?";
        Post post = null;
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    post = new Post();
                    post.setId(rs.getInt("id"));
                    post.setTitle(rs.getString("title"));
                    post.setContent(rs.getString("content"));
                    post.setUser(rs.getString("user"));
                    post.setCreatedAt(rs.getString("createdAt"));
                }
            }
        }
        return post;
    }

    // 페이지네이션용
    public List<Post> getPosts(int page, int pageSize) throws SQLException {
        String sql = "SELECT * FROM post ORDER BY id DESC LIMIT ?, ?";
        List<Post> posts = new ArrayList<>();

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, (page - 1) * pageSize); // OFFSET
            pstmt.setInt(2, pageSize); // LIMIT

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Post post = new Post();
                    post.setId(rs.getInt("id"));
                    post.setTitle(rs.getString("title"));
                    post.setContent(rs.getString("content"));
                    post.setUser(rs.getString("user"));
                    post.setCreatedAt(rs.getString("createdAt")); // Timestamp로 변경
                    posts.add(post);
                }
            }
        }
        return posts;
    }

    // 전체 게시글 수 가져오는 메서드 추가
    public int getTotalPosts() {
        int totalPosts = 0;
        try {
            String sql = "SELECT COUNT(*) FROM post";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                totalPosts = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalPosts;
    }

    // UPDATE
    public void updatePost(Post post) throws SQLException {
        String sql = "UPDATE post SET title = ?, content = ?, user = ? WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getContent());
            pstmt.setString(3, post.getUser());
            pstmt.setInt(4, post.getId());
            pstmt.executeUpdate();
        }
    }

    // DELETE
    public void deletePost(int id) throws SQLException {
        String sql = "DELETE FROM post WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
    }
}
