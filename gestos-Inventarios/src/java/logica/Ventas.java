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
public class Ventas {
    private int numFactura;
    private String fecha;
    private int nomProducto;
    private int cantidad;
    private Producto producto;
    

    public Ventas() {
    }

    public Ventas(int numFactura) {
        this.numFactura = numFactura;
    }

    public Ventas(int numFactura, String fecha, int nomProducto, int cantidad) {
        this.numFactura = numFactura;
        this.fecha = fecha;
        this.nomProducto = nomProducto;
        this.cantidad = cantidad;
        
    }

    public int getNumFactura() {
        return numFactura;
    }

    public void setNumFactura(int numFactura) {
        this.numFactura = numFactura;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public int getNomProducto() {
        return nomProducto;
    }

    public void setNomProducto(int nomProducto) {
        this.nomProducto = nomProducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    @Override
    public String toString() {
        return "Compras{" + "numFactura=" + numFactura + ", fecha=" + fecha + ", nomProducto=" + nomProducto + ", cantidad=" + cantidad + '}';
    }
    
     //Metodo de listar
    public List<Ventas> consultarVentas(){
        ConexionBD conexion = new ConexionBD();
        List<Ventas> consultarVentas = new ArrayList<>();
        String sql ="SELECT * FROM ventas;";
        ResultSet rs = conexion.consultarBD(sql);
        
        try { 
            Ventas c;
            while(rs.next()){
                c = new Ventas();
                
               c.setNumFactura(rs.getInt("numFactura"));
               c.setFecha(rs.getString("fecha"));
               c.setNomProducto(rs.getInt("nomProducto"));
               c.setCantidad(rs.getInt("cantidad"));
               
               Producto pro = new Producto(c.getNomProducto()).consultarProducto();
               c.setProducto(pro);
     
               consultarVentas.add(c);
            } 
        }catch (SQLException ex) {
                Logger.getLogger(Ventas.class.getName()).log(Level.SEVERE, null, ex);
            }finally{
                conexion.cerrarConexion();
            }
    return consultarVentas;
    }
    //Metodo de consulta individual 
    public Ventas consultarVenta(){
        ConexionBD conexion = new ConexionBD();
        String sql ="SELECT * FROM ventas WHERE numFactura='"+ this.numFactura +"';";
        ResultSet rs = conexion.consultarBD(sql);
        try { 
            if(rs.next()){
                
                this.fecha = rs.getString("fecha");
                this.nomProducto = rs.getInt("nomProducto");
                this.cantidad = rs.getInt("cantidad");
            }    
            else{
                return null;     
            } 
        }catch (SQLException ex) {
                Logger.getLogger(Ventas.class.getName()).log(Level.SEVERE, null, ex);
            }finally{
                conexion.cerrarConexion();
            }
        return this;
    }
    public boolean guardarVentas(){
        ConexionBD conexion = new ConexionBD();
        String sql="INSERT INTO ventas\n"
                    + "( fecha,nomProducto,cantidad)\n"
                    + " VALUES ('"+ this.fecha +"','"+ this.nomProducto +"','"+ this.cantidad +"');";


        if(conexion.setAutoCommitBD(false)){
           if(conexion.insertarBD(sql)){
             conexion.commitBD();
             conexion.cerrarConexion();
             return true;
           }else{
             conexion.cerrarConexion();
             return false;
           }
        }else{
           conexion.cerrarConexion();
           return false;
        }
    }
    public boolean actualizarVenta(){
        ConexionBD conexion = new ConexionBD();
        String sql = "UPDATE ventas SET "+ 
                         " fecha = '"+ this.fecha +"', "+
                         " nomProducto = '"+ this.nomProducto +"', "+
                         " cantidad = '"+ this.cantidad+"'"+
                         " WHERE numFactura = '"+ this.numFactura +"'; ";
        
        if(conexion.setAutoCommitBD(false)){
            if(conexion.actualizarBD(sql)){
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            }else{
                conexion.cerrarConexion();
                return false;
            }
        }else{
            conexion.cerrarConexion();
            return false;
        }    
    
    }
    public boolean eliminarVenta(){
        ConexionBD conexion = new ConexionBD();
        String sql = "DELETE FROM ventas\n"
                + "WHERE numFactura='" + this.numFactura + "';";
        if(conexion.setAutoCommitBD(false)){
            if(conexion.actualizarBD(sql)){
                conexion.commitBD();
                conexion.cerrarConexion();
                return true;
            }else{
                conexion.cerrarConexion();
                return false;
            }
        }else{
            conexion.cerrarConexion();
            return false;
        }    
    
    }
}
