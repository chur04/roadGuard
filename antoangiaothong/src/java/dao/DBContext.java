/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author im_chur
 */
    public class DBContext {
        private static DBContext instance = new DBContext() ; 
        Connection connection ; 

        public static DBContext getInstance() {
            return instance ; 
        }

        public Connection  getConnection(){
            return connection ; 
        }

        private DBContext() {
            try {
                if (connection == null || connection.isClosed()){
                    String user = "sa" ; 
                    String password = "123" ; 
                    String url="jdbc:sqlserver://localhost:1433;databaseName=PRJASS1;TrustServerCertificate=true;";

                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    connection = DriverManager.getConnection(url, user, password);

                }
            } catch(Exception e) {
                connection = null ;
                  e.printStackTrace(); 
            }
        }
    }
