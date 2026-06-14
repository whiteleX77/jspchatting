package bean;

import java.sql.Connection;
import java.sql.DriverManager;

public class Dbcon {
	// 1. 新版驱动类名必须带 .cj.
	private static final String DRIVER_CLASS = "com.mysql.cj.jdbc.Driver";

	// 2. URL 必须加上 serverTimezone=Asia/Shanghai 时区参数
	private static final String DATABASE_URL = "jdbc:mysql://localhost:3306/chatroomdb?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai&useSSL=false&allowPublicKeyRetrieval=true";
	// 3. 检查你的用户名和密码是否拼写正确（原图中有个变量名拼成了 USRE，这里已修正）
	private static final String DATABASE_USER = "root";
	private static final String DATABASE_PASSWORD = "589964544gjh";

	public static Connection getConnction() {
		Connection dbCon = null;
		try {
			Class.forName(DRIVER_CLASS);
			dbCon = DriverManager.getConnection(DATABASE_URL, DATABASE_USER, DATABASE_PASSWORD);
		} catch (Exception e) {
			// 务必加上这句打印，如果再连不上，IDEA控制台就会输出真正的错误原因！
			System.err.println("❌ 数据库连接失败！请看下方的详细错误信息：");
			e.printStackTrace();
		}
		return dbCon;
	}
}