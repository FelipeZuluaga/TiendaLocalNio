<%@page import="logica.Provedores"%>
<%@page import="logica.Producto"%>
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
            // creación de objeto y llamado a método guardar 
            
            String nombreProducto = request.getParameter("nombreProducto");
            int Stop = Integer.parseInt(request.getParameter("Stop"));
            int precioProducto = Integer.parseInt(request.getParameter("precioProducto"));
            String descripcion = request.getParameter("descripcion");
            int Provedor = Integer.parseInt(request.getParameter("Provedor"));
            
            Producto p = new Producto();
            p.setNombreProducto(nombreProducto);
            p.setStop(Stop);
            p.setPrecioProducto(precioProducto);
            p.setDescripcion(descripcion);
            p.setProvedor(Provedor);
            
            if (p.guardarProducto()) { 
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("eliminar")) {
        //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado a método eliminar
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            Producto p = new Producto();
            p.setIdProducto(idProducto);
            
            if (p.eliminarProducto()) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("listar")) {
        //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
           //creación de objeto y llamado al metodo listar
            try {
                List<Producto> lista = new Producto().consultarProductos();
                respuesta += "\"" + proceso + "\": true,\"Productos\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"Productos\":[]";
                Logger.getLogger(Producto.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else if (proceso.equals("consultarIndividual")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo consultarIndividual
            try {
                int idProducto = Integer.parseInt(request.getParameter("idProducto"));
                Producto obj = new Producto(idProducto).consultarProducto();
                respuesta += "\"" + proceso + "\": true,\"Producto\":" + new Gson().toJson(obj);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\" Producto\":null";
                Logger.getLogger(Producto.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        }else if (proceso.equals("actualizar")) {
            //creación de objeto y llamado al metodo actualizar
            int idProducto = Integer.parseInt(request.getParameter("idProducto"));
            String nombreProducto = request.getParameter("nombreProducto");
            int Stop = Integer.parseInt(request.getParameter("Stop"));
            int precioProducto = Integer.parseInt(request.getParameter("precioProducto"));
            String descripcion = request.getParameter("descripcion");
            int Provedor = Integer.parseInt(request.getParameter("Provedor"));
            
            Producto p = new Producto();
            p.setIdProducto(idProducto);
            p.setNombreProducto(nombreProducto);
            p.setStop(Stop);
            p.setPrecioProducto(precioProducto);
            p.setDescripcion(descripcion);
            p.setProvedor(Provedor);
          
            
            
            if (p.actulizarProducto()) {                     
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
