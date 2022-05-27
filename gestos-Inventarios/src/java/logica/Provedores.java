/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logica;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import persistencia.ConexionBD;

/**
 *
 * @author black
 */
public class Provedores {
    
    private int idProvedor;
    private String nombreProvedorPk;
    private int telefono;

    public Provedores() {
    }

    public Provedores(int idProvedor) {
        this.idProvedor = idProvedor;
    }
    

    public Provedores(int idProvedor, String nombreProvedorPk, int telefono) {
        this.idProvedor = idProvedor;
        this.nombreProvedorPk = nombreProvedorPk;
        this.telefono = telefono;
    }

    public int getIdProvedor() {
        return idProvedor;
    }

    public void setIdProvedor(int idProvedor) {
        this.idProvedor = idProvedor;
    }

    public String getNombreProvedorPk() {
        return nombreProvedorPk;
    }

    public void setNombreProvedorPk(String nombreProvedorPk) {
        this.nombreProvedorPk = nombreProvedorPk;
    }

    public int getTelefono() {
        return telefono;
    }

    public void setTelefono(int telefono) {
        this.telefono = telefono;
    }

    @Override
    public String toString() {
        return "Provedores{" + "idProvedor=" + idProvedor + ", nombreProvedorPk=" + nombreProvedorPk + ", telefono=" + telefono + '}';
    }
    
    //Metodo para consultar 
    public List<Provedores> consultarProvedores(){
       
            ConexionBD conexion = new ConexionBD();
            List<Provedores> listaProvedores = new ArrayList<>();
            String sql = "SELECT * FROM provedores;";
            ResultSet rs = conexion.consultarBD(sql);
        try { 
            Provedores pro;
            while(rs.next()){
                pro = new Provedores();
                
                pro.setIdProvedor(rs.getInt("idProvedor"));
                pro.setNombreProvedorPk(rs.getString("nombreProvedorPk"));
                pro.setTelefono(rs.getInt("telefono"));
                
                listaProvedores.add(pro);  
            }
       
            }catch (SQLException ex) {
                Logger.getLogger(Provedores.class.getName()).log(Level.SEVERE, null, ex);
            }finally{
                conexion.cerrarConexion();
            }
            return listaProvedores;
    }
    //Metodo de consulta individual 
    public Provedores consultarProvedor(){
        ConexionBD conexion = new ConexionBD();
        String sql = "SELECT * FROM provedores WHERE idProvedor='" +this.idProvedor+"';";
        ResultSet rs = conexion.consultarBD(sql);
        
        try { 
            if(rs.next()){
                this.nombreProvedorPk = rs.getString("nombreProvedorPk");
                this.telefono = rs.getInt("telefono");
            }    
            else{
                return null;     
            } 
        }catch (SQLException ex) {
                Logger.getLogger(Provedores.class.getName()).log(Level.SEVERE, null, ex);
            }finally{
                conexion.cerrarConexion();
            }
        return this;
    }
    
    
    //Metodo de crear provedores
    public boolean guardarProvedores(){
        ConexionBD conexion = new ConexionBD();
        String sql = "INSERT INTO provedores\n"
                    + "(nombreProvedorPk,telefono)\n"
                    + " VALUES ('"+ this.nombreProvedorPk +"','"+ this.telefono +"');";
        
        if(conexion.setAutoCommitBD(false)){
            
            if(conexion.insertarBD(sql)){
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            }else{
                conexion.rollbackBD();
                conexion.cerrarConexion();
                return false;
            }    
        }else{
            conexion.cerrarConexion();
            return false;
        }

    }
    //Metodo de Actulizar Provedores
    public boolean actulizarProvedor(){
        ConexionBD conexion = new ConexionBD();
        String sql =  "UPDATE  provedores\n"
                    + "SET telefono='"+this.telefono+"'\n"
                    + "nombreProvedorPk='"+ this.nombreProvedorPk +"'"
                    + "WHERE idProvedor='"+ this.idProvedor +"';";
        
        if(conexion.setAutoCommitBD(false)){
            
            if(conexion.actualizarBD(sql)){
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            }else{
                conexion.rollbackBD();
                conexion.cerrarConexion();
                return false;
            }    
        }else{
            conexion.cerrarConexion();
            return false;
        }

    }
    //metodo de eliminar Provedores 
    public boolean eliminarProvedor(){
        ConexionBD conexion = new ConexionBD();
        String sql = "DELETE FROM  provedores\n"
                    + "WHERE idProvedor='"+ this.idProvedor +"';";
        
        if(conexion.setAutoCommitBD(false)){
            
            if(conexion.actualizarBD(sql)){
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            }else{
                conexion.rollbackBD();
                conexion.cerrarConexion();
                return false;
            }    
        }else{
            conexion.cerrarConexion();
            return false;
        }

    }
    
    
  
}
    
    

