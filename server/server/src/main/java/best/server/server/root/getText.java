package best.server.server.root;

import java.sql.*;

public class getText {
    public static final String DB_URL = "jdbc:mysql://localhost:3306/architecture?useUnicode=true&serverTimezone=Asia/Seoul";
    public static final String DB_USER = "root";
    public static final String DB_PASSWD = "qndud";
    public static void main(String[] args) {
        try(Connection conn = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWD);
            Statement state = conn.createStatement();
        ) {
            String query = "SELECT * FROM contents";
            ResultSet rs = state.executeQuery(query);

            while(rs.next()){
                String contents = rs.getString("content");

                System.out.println(contents);
            }
        }catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
