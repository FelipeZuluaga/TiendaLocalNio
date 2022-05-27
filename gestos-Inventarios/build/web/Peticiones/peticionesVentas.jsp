<%@page import="logica.Ventas"%>
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
           
            
            Ventas v = new Ventas();
            
            v.setFecha(fecha);
            v.setNomProducto(nomProducto);
            v.setCantidad(cantidad);
           
            
            
            
            if (v.guardarVentas()) { 
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminar")) {
        //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado a método eliminar
            
            int numFactura = Integer.parseInt(request.getParameter("numFactura"));
            Ventas v = new Ventas();
            v.setNumFactura(numFactura);
            
            if (v.eliminarVenta()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listar")) {
        //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
           //creación de objeto y llamado al metodo listar
            try {
                List<Ventas> lista = new Ventas().consultarVentas();
                respuesta += "\"" + proceso + "\": true,\"Ventas\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Ventas\":[]";
                Logger.getLogger(Ventas.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else if (proceso.equals("consultarIndividual")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo consultarIndividual
            
            try {
                int numFactura = Integer.parseInt(request.getParameter("numFactura"));
                Ventas obj = new Ventas(numFactura).consultarVenta();
                respuesta += "\"" + proceso + "\": true,\"Venta\":" + new Gson().toJson(obj);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\" Venta\":null";
                Logger.getLogger(Ventas.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        }else if (proceso.equals("actualizar")) {
            //creación de objeto y llamado al metodo actualizar
            
            int numFactura = Integer.parseInt(request.getParameter("numFactura"));
            String fecha = request.getParameter("fecha");
            int nomProducto = Integer.parseInt(request.getParameter("nomProducto"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            
            
            Ventas v = new Ventas();
            v.setNumFactura(numFactura);
            v.setFecha(fecha);
            v.setNomProducto(nomProducto);
            v.setCantidad(cantidad);
             
            
            if (v.actualizarVenta()) {                     
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
