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
public class Producto {
    
    private int idProducto;
    private String nombreProducto;
    private int Stop;
    private int precioProducto;
    private String descripcion;
    private int Provedor;
    private Provedores provedor;

    public Producto() {
    }

    public Producto(int idProducto) {
        this.idProducto = idProducto;
    }

    public Producto(int idProducto, String nombreProducto, int Stop, int precioProducto, String descripcion, int Provedor) {
        this.idProducto = idProducto;
        this.nombreProducto = nombreProducto;
        this.Stop = Stop;
        this.precioProducto = precioProducto;
        this.descripcion = descripcion;
        this.Provedor = Provedor;
    }

    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombreProducto() {
        return nombreProducto;
    }

    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }

    public int getStop() {
        return Stop;
    }

    public void setStop(int Stop) {
        this.Stop = Stop;
    }

    public int getPrecioProducto() {
        return precioProducto;
    }

    public void setPrecioProducto(int precioProducto) {
        this.precioProducto = precioProducto;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getProvedor() {
        return Provedor;
    }

    public void setProvedor(int Provedor) {
        this.Provedor = Provedor;
    }
    public Provedores getProvedores() {
        return provedor;
    }

    public void setProvedores(Provedores provedor) {
        this.provedor = provedor;
    }

    @Override
    public String toString() {
        return "Producto{" + "idProducto=" + idProducto + ", nombreProducto=" + nombreProducto + ", Stop=" + Stop + ", precioProducto=" + precioProducto + ", descripcion=" + descripcion + ", Provedor=" + Provedor + '}';
    }

    
    public List<Producto> consultarProductos(){
        ConexionBD conexion = new ConexionBD();
        List<Producto> consultarProductos = new ArrayList<>();
        String sql ="SELECT * FROM productos;";
        ResultSet rs = conexion.consultarBD(sql);
        
        try { 
            Producto p;
            while(rs.next()){
                p = new Producto();
            
                p.setIdProducto(rs.getInt("idProducto"));
                p.setNombreProducto(rs.getString("nombreProducto"));
                p.setStop(rs.getInt("Stop"));
                p.setPrecioProducto(rs.getInt("precioProducto"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setProvedor(rs.getInt("Provedor"));
                
                Provedores pro = new Provedores(p.getProvedor()).consultarProvedor();
                p.setProvedores(pro);
                consultarProductos.add(p);
                
            } 
        }catch (SQLException ex) {
                Logger.getLogger(Producto.class.getName()).log(Level.SEVERE, null, ex);
            }finally{
                conexion.cerrarConexion();
            }
    return consultarProductos;
    }
    //Metodo de consulta individual 
    public Producto consultarProducto(){
        ConexionBD conexion = new ConexionBD();
        String sql ="SELECT * FROM productos WHERE idProducto='"+ this.idProducto +"';";
        ResultSet rs = conexion.consultarBD(sql);
        try { 
            if(rs.next()){
                
                this.nombreProducto = rs.getString("nombreProducto");
                this.Stop = rs.getInt("Stop");
                this.precioProducto = rs.getInt("precioProducto");
                this.descripcion = rs.getString("descripcion");
                this.Provedor = rs.getInt("Provedor");
                this.provedor = new Provedores(this.Provedor).consultarProvedor();
            }    
            else{
                return null;     
            } 
        }catch (SQLException ex) {
                Logger.getLogger(Producto.class.getName()).log(Level.SEVERE, null, ex);
            }finally{
                conexion.cerrarConexion();
            }
        return this;
    }
    
    
    //Metodo de crear 
    public boolean guardarProducto(){
        ConexionBD conexion = new ConexionBD();
        String sql = "INSERT INTO productos\n"
                    + "(nombreProducto,Stop,precioProducto,descripcion,Provedor)\n"
                    + " VALUES ('"+ this.nombreProducto +"','"+ this.Stop +"','"+this.precioProducto+"','"+this.descripcion+"','"+this.Provedor+"');";
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
    //metodo de actulizar 
    public boolean actulizarProducto(){
        ConexionBD conexion = new ConexionBD();
        String sql = "UPDATE productos SET "+ 
                         " nombreProducto = '"+ this.nombreProducto +"', "+
                         " Stop = '"+ this.Stop+"', "+
                         " precioProducto= '"+ this.precioProducto+"', "+
                         " descripcion= '"+ this.descripcion+"', "+
                         " Provedor= '"+ this.Provedor+"'"+
                         " WHERE idProducto = '"+ this.idProducto +"'; ";
        
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
        }
        else{
            conexion.cerrarConexion();
            return false;
        }
    }
    //MEtodo de eliminar Producto 
     public boolean eliminarProducto(){
        ConexionBD conexion = new ConexionBD();
        String sql ="DELETE FROM productos WHERE idProducto ='"+ this.idProducto +"';";
        
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
        }
        else{
            conexion.cerrarConexion();
            return false;
        }
    }
     
    
}
