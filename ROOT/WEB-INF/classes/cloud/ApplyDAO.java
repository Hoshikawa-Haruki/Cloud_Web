package cloud;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApplyDAO {
    private Connection conn;

    public ApplyDAO(Connection conn) {
        this.conn = conn;
    }

    // CREATE
    public void createApply(Apply apply) throws SQLException {
        String sql = "INSERT INTO apply (name, studentNumber, phone, email, department, introduction, interest, userId, createdAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, NOW())";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, apply.getName());
            pstmt.setString(2, apply.getStudentNumber());
            pstmt.setString(3, apply.getPhone());
            pstmt.setString(4, apply.getEmail());
            pstmt.setString(5, apply.getDepartment());
            pstmt.setString(6, apply.getIntroduction());
            pstmt.setString(7, apply.getInterest());
            pstmt.setString(8, apply.getUserId());
            pstmt.executeUpdate();
        }
    }

    // READ (모든 신청서 조회)
    public List<Apply> getAllApplies() throws SQLException {
        String sql = "SELECT * FROM apply";
        List<Apply> applies = new ArrayList<>();
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                Apply apply = new Apply();
                apply.setId(rs.getInt("id"));
                apply.setName(rs.getString("name"));
                apply.setStudentNumber(rs.getString("studentNumber"));
                apply.setPhone(rs.getString("phone"));
                apply.setEmail(rs.getString("email"));
                apply.setDepartment(rs.getString("department"));
                apply.setIntroduction(rs.getString("introduction"));
                apply.setInterest(rs.getString("interest"));
                apply.setCreatedAt(rs.getString("createdAt"));
                // 승인여부, 유저아이디
                apply.setIsApply(rs.getInt("isApply"));
                apply.setUserId(rs.getString("userId"));
                applies.add(apply);
            }
        }
        return applies;
    }

    // READ (특정 신청서 조회)
    public Apply getApplyById(int id) throws SQLException {
        String sql = "SELECT * FROM apply WHERE id = ?";
        Apply apply = null;
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    apply = new Apply();
                    apply.setId(rs.getInt("id"));
                    apply.setName(rs.getString("name"));
                    apply.setStudentNumber(rs.getString("studentNumber"));
                    apply.setPhone(rs.getString("phone"));
                    apply.setEmail(rs.getString("email"));
                    apply.setDepartment(rs.getString("department"));
                    apply.setIntroduction(rs.getString("introduction"));
                    apply.setInterest(rs.getString("interest"));
                    apply.setCreatedAt(rs.getString("createdAt"));
                    // 승인여부, 유저아이디
                    apply.setIsApply(rs.getInt("isApply"));
                    apply.setUserId(rs.getString("userId"));
                }
            }
        }
        return apply;
    }

    // 페이지네이션용
    public List<Apply> getApplies(int page, int pageSize) throws SQLException {
        String sql = "SELECT * FROM apply ORDER BY id DESC LIMIT ?, ?";
        List<Apply> applies = new ArrayList<>();

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, (page - 1) * pageSize); // OFFSET
            pstmt.setInt(2, pageSize); // LIMIT

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Apply apply = new Apply();
                    apply.setId(rs.getInt("id"));
                    apply.setName(rs.getString("name"));
                    apply.setStudentNumber(rs.getString("studentNumber"));
                    apply.setPhone(rs.getString("phone"));
                    apply.setEmail(rs.getString("email"));
                    apply.setDepartment(rs.getString("department"));
                    apply.setIntroduction(rs.getString("introduction"));
                    apply.setInterest(rs.getString("interest"));
                    apply.setCreatedAt(rs.getString("createdAt"));
                    // 승인여부, 유저아이디
                    apply.setIsApply(rs.getInt("isApply"));
                    apply.setUserId(rs.getString("userId"));
                    applies.add(apply);
                }
            }
        }
        return applies;
    }

    // 전체 신청서 수 가져오는 메서드 추가
    public int getTotalApplies() throws SQLException {
        int totalApplies = 0;
        String sql = "SELECT COUNT(*) FROM apply";
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
        
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                totalApplies = rs.getInt(1);
            }
        }
        return totalApplies;
    }

    public int getisApply(String userId) throws SQLException{
        String sql = "select isApply from apply where userId = ?";
        int isApply=0;
        
        try(PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setString(1,userId);
            ResultSet rs = pstmt.executeQuery();
            if(rs.next()){
            isApply=rs.getInt("isApply");
            }
        }catch(SQLException e){
            e.printStackTrace();
        }
        return isApply;
    }


    // UPDATE
    public void updateApply(Apply apply) throws SQLException {
        String sql = "UPDATE apply SET name = ?, studentNumber = ?, phone = ?, email = ?, department = ?, introduction = ?, interest = ? WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, apply.getName());
            pstmt.setString(2, apply.getStudentNumber());
            pstmt.setString(3, apply.getPhone());
            pstmt.setString(4, apply.getEmail());
            pstmt.setString(5, apply.getDepartment());
            pstmt.setString(6, apply.getIntroduction());
            pstmt.setString(7, apply.getInterest());
            pstmt.setInt(8, apply.getId());
            pstmt.executeUpdate();
        }
    }

    // DELETE
    public void deleteApply(int id) throws SQLException {
        String sql = "DELETE FROM apply WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        }
    }

    public void updateisMember(int id) throws SQLException{
        String sql = "select userId from apply where id =?";
        try(PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setInt(1,id);
            try(ResultSet rs = pstmt.executeQuery()){
                if(rs.next()){
                    String userId = rs.getString("userId");
                    sql = "update user set isMember = 1 where userId = ?";
                    try(PreparedStatement pstmt2 = conn.prepareStatement(sql)){
                        pstmt2.setString(1,userId);
                        pstmt2.executeUpdate();
                    }
                }
            }
        }
    }

    public void updateisApply(int id) throws SQLException{
        String sql = "update apply set isApply=1 where id=?";
        try(PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setInt(1,id);
            pstmt.executeUpdate();
        }
    }
}
