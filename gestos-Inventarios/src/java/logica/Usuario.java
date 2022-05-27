/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logica;

import java.sql.ResultSet;
import java.sql.SQLException;
import persistencia.ConexionBD;

/**
 *
 * @author black
 */
public class Usuario {
    private String nombreDeUsuario;
    private String contrasena;

    public Usuario() {
    }

    public Usuario(String nombreDeUsuario, String contrasena) {
        this.nombreDeUsuario = nombreDeUsuario;
        this.contrasena = contrasena;
    }

    public String getNombreDeUsuario() {
        return nombreDeUsuario;
    }

    public void setNombreDeUsuario(String nombreDeUsuario) {
        this.nombreDeUsuario = nombreDeUsuario;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    @Override
    public String toString() {
        return "Usuario{" + "nombreDeUsuario=" + nombreDeUsuario + ", contrasena=" + contrasena + '}';
    }
    
    public Usuario validarUsuario(){
        ConexionBD conexion =new ConexionBD();
        String sql="SELECT nombreDeUsuario FROM usuarios WHERE nombreDeUsuario='"+this.nombreDeUsuario+"'AND contrasena='"+this.contrasena+"';";
        ResultSet rs= conexion.consultarBD(sql);
        
        try{
            if(rs.next()){
                this.contrasena="";
            }else{
                return null;
            }
        
        }catch(SQLException ex){
            System.out.println("Error; "+ex.getMessage());
        }finally{
            conexion.cerrarConexion();
        }
        return this;   
    }    
}
