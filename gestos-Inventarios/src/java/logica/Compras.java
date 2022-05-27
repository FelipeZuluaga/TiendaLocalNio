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
public class Compras {
    private int numFactura;
    private String fecha;
    private int nomProducto;
    private int cantidad;
    private Producto producto;
    private int Stop;

    public Compras() {
    }

    public Compras(int numFactura) {
        this.numFactura = numFactura;
    }

    public Compras(int numFactura, String fecha, int nomProducto, int cantidad) {
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

    public int getStop() {
        return Stop;
    }

    public void setStop(int Stop) {
        this.Stop = Stop;
    }
    

    @Override
    public String toString() {
        return "Compras{" + "numFactura=" + numFactura + ", fecha=" + fecha + ", nomProducto=" + nomProducto + ", cantidad=" + cantidad + '}';
    }
    
     //Metodo de listar
    public List<Compras> consultarCompras(){
        ConexionBD conexion = new ConexionBD();
        List<Compras> consultarCompras = new ArrayList<>();
        String sql ="SELECT * FROM compras;";
        ResultSet rs = conexion.consultarBD(sql);
        
        try { 
            Compras c;
            while(rs.next()){
                c= new Compras();
                
               c.setNumFactura(rs.getInt("numFactura"));
               c.setFecha(rs.getString("fecha"));
               c.setNomProducto(rs.getInt("nomProducto"));
               c.setCantidad(rs.getInt("cantidad"));
               
               Producto pro = new Producto(c.getNomProducto()).consultarProducto();
               c.setProducto(pro);
     
               consultarCompras.add(c);
            } 
        }catch (SQLException ex) {
                Logger.getLogger(Compras.class.getName()).log(Level.SEVERE, null, ex);
            }finally{
                conexion.cerrarConexion();
            }
    return consultarCompras;
    }
    //Metodo de consulta individual 
    public Compras consultarCompra(){
        ConexionBD conexion = new ConexionBD();
        String sql ="SELECT * FROM compras WHERE numFactura='"+ this.numFactura +"';";
        ResultSet rs = conexion.consultarBD(sql);
        try { 
            if(rs.next()){
                
                this.fecha = rs.getString("fecha");
                this.nomProducto = rs.getInt("nomProducto");
                this.cantidad = rs.getInt("cantidad");
                this.producto = new Producto(this.nomProducto).consultarProducto();
            }    
            else{
                return null;     
            } 
        }catch (SQLException ex) {
                Logger.getLogger(Compras.class.getName()).log(Level.SEVERE, null, ex);
            }finally{
                conexion.cerrarConexion();
            }
        return this;
    }
    public boolean guardarCompras(){
        ConexionBD conexion = new ConexionBD();
        String sql="INSERT INTO compras\n"
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
    public boolean actualizarCompra(){
        ConexionBD conexion = new ConexionBD();
        String sql = "UPDATE compras SET "+ 
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
    public boolean eliminarCompra(){
        ConexionBD conexion = new ConexionBD();
        String sql = "DELETE FROM compras\n"
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
