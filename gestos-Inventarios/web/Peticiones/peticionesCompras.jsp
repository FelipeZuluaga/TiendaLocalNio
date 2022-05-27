
<%@page import="logica.Compras"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="application/json;charset=iso-8859-1" language="java" pageEncoding="iso-8859-1" session="true"%>

<%    // Iniciando respuesta JSON.
    String respuesta = "{";

    //Lista de procesos o tareas a realizar 
    List<String> tareas = Arrays.asList(new String[]{
        "guardar",
        "eliminar",
        "actualizar",
        "consultarIndividual",
        "listar"
    });
    
    String proceso = "" + request.getParameter("proceso");
    
    // Validación de parámetros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("guardar")) {

            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            // creación de objeto y llamado a método guardar//
            String fecha = request.getParameter("fecha");
            int nomProducto = Integer.parseInt(request.getParameter("nomProducto"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
           
            
            Compras c = new Compras();
            
            c.setFecha(fecha);
            c.setNomProducto(nomProducto);
            c.setCantidad(cantidad);
           
            
            
            
            if (c.guardarCompras()) { 
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminar")) {
        //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado a método eliminar
            
            int numFactura = Integer.parseInt(request.getParameter("numFactura"));
            Compras c = new Compras();
            c.setNumFactura(numFactura);
            
            if (c.eliminarCompra()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listar")) {
        //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
           //creación de objeto y llamado al metodo listar
            try {
                List<Compras> lista = new Compras().consultarCompras();
                respuesta += "\"" + proceso + "\": true,\"Compras\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Compras\":[]";
                Logger.getLogger(Compras.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else if (proceso.equals("consultarIndividual")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo consultarIndividual
            
            try {
                int numFactura = Integer.parseInt(request.getParameter("numFactura"));
                Compras obj = new Compras(numFactura).consultarCompra();
                respuesta += "\"" + proceso + "\": true,\"Compra\":" + new Gson().toJson(obj);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Compra\":null";
                Logger.getLogger(Compras.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        }else if (proceso.equals("actualizar")) {
            //creación de objeto y llamado al metodo actualizar
            
            int numFactura = Integer.parseInt(request.getParameter("numFactura"));
            String fecha = request.getParameter("fecha");
            int nomProducto = Integer.parseInt(request.getParameter("nomProducto"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            
            
            Compras c = new Compras();
            c.setNumFactura(numFactura);
            c.setFecha(fecha);
            c.setNomProducto(nomProducto);
            c.setCantidad(cantidad);
             
            
            if (c.actualizarCompra()) {                     
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        }
        

        // ------------------------------------------------------------------------------------- //
        // -----------------------------------FIN PROCESOS-------------------------------------- //
        // ------------------------------------------------------------------------------------- //
        // Proceso desconocido.
    } else {
        respuesta += "\"ok\": false,";
        respuesta += "\"error\": \"INVALID\",";
        respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
                + " son inválidos. Corrijalos y vuelva a intentar por favor.\"";
    }    
    // Responder como objeto JSON codificación ISO 8859-1.
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>
