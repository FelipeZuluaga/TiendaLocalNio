package persistencia;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

public class ConexionBD {

    // Configuracion de la conexion a la base de datos 
    private String DB_driver = "";
    private String url = "";
    private String db = "";
    private String host = "";
    private String username = "";
    private String password = "";           //ATRIBUTOS
    public Connection con = null;
    private Statement stmt = null;
    //private PreparedStatement pstmt = null;
    private ResultSet rs = null;

    //Constructor sin parmetros		
    public ConexionBD() {

        DB_driver = "com.mysql.cj.jdbc.Driver";
        host = "localhost:3306";
        db = "prueba1";
        url = "jdbc:mysql://" + host + "/" + db + "?serverTimezone=UTC"; 		                  //URL DB
        username = "root";                      //zona horaria			                          //usuario base de datos global 
        password = "";

        try {
            //Asignacin del Driver
            Class.forName(DB_driver);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            // Realizar la conexion
            con = DriverManager.getConnection(url, username, password);
            con.setTransactionIsolation(8);
            //JOptionPane.showMessageDialog(null, "CONECTADO 😎👽🤐🤔😬😁😂");
        } catch (SQLException ex) {
            Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
        }
        // Realizar la conexin
    }
//------------------------------------------------------------------------------------------------------------------------------
    //Retornar la conexin

    public java.sql.Connection getConnection() {
        return con;
    }

    //Cerrar la conexin 
    public void closeConnection(java.sql.Connection con) {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(ConexionBD.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
//------------------------------------------------------------------------------------------------------------------------------

    // Mtodo que devuelve un ResultSet de una consulta (tratamiento de SELECT)
    public ResultSet consultarBD(String sentencia) {
        try {
            stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            rs = stmt.executeQuery(sentencia);
        } catch (SQLException sqlex) {
        } catch (RuntimeException rex) {
        } catch (Exception ex) {
        }

        return rs;
    }
//------------------------------------------------------------------------------------------------------------------------------
    // Mtodo que realiza un INSERT y devuelve TRUE si la operacin fue existosa

    public boolean insertarBD(String sentencia) {
        try {
            stmt = con.createStatement();
            stmt.execute(sentencia);
        } catch (SQLException | RuntimeException sqlex) {
            JOptionPane.showMessageDialog(null, "ERROR RUTINA: " + sqlex);
            return false;
        }
        return true;
    }
//------------------------------------------------------------------------------------------------------------------------------

    public boolean borrarBD(String sentencia) {
        try {
            stmt = con.createStatement();
            stmt.execute(sentencia);
        } catch (SQLException | RuntimeException sqlex) {
            JOptionPane.showMessageDialog(null, "ERROR RUTINA: " + sqlex);
            return false;

        }
        return true;
    }
//------------------------------------------------------------------------------------------------------------------------------
    // Mtodo que realiza una operacin como UPDATE, DELETE, CREATE TABLE, entre otras
    // y devuelve TRUE si la operacin fue existosa

    public boolean actualizarBD(String sentencia) {
        try {
            stmt = con.createStatement();
            stmt.executeUpdate(sentencia);
        } catch (SQLException | RuntimeException sqlex) {
            JOptionPane.showMessageDialog(null, "ERROR RUTINA: " + sqlex);
            return false;
        }
        return true;
    }
//------------------------------------------------------------------------------------------------------------------------------

    public boolean setAutoCommitBD(boolean parametro) {
        try {
            con.setAutoCommit(parametro);
        } catch (SQLException sqlex) {
            JOptionPane.showMessageDialog(null, "Error al configurar el autoCommit " + sqlex.getMessage());  //CONFIRMAR EL parametro
            return false;
        }
        return true;
    }
//------------------------------------------------------------------------------------------------------------------------------

    public void cerrarConexion() {
        closeConnection(con);
    }
//------------------------------------------------------------------------------------------------------------------------------

    public boolean commitBD() {
        try {
            con.commit();
            return true;                     // 
        } catch (SQLException sqlex) {
            JOptionPane.showMessageDialog(null, "Error al hacer commit " + sqlex.getMessage());
            return false;
        }
    }
//------------------------------------------------------------------------------------------------------------------------------

    public boolean rollbackBD() {
        try {
            con.rollback();
            return true;
        } catch (SQLException sqlex) {
            JOptionPane.showMessageDialog(null, "Error al hacer rollback " + sqlex.getMessage());
            return false;
        }
    }

    public static void main(String[] args) {
        ConexionBD b = new ConexionBD();
        b.cerrarConexion();
    }

}


