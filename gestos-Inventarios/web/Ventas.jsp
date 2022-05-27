<%@page import="logica.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js" integrity="sha384-VHvPCCyXqtD5DqJeNxl2dtTyhF78xXNXdkwX1CZeRusQfRKp+tA7hAShOK/B/fQ2" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <style>
         
            td{
                border: ridge
            }
            .sesion{
                background-color:  #193d72;
            }
            h3{
                color:  white;
            }
            .table{
                text-align:center;     
            }
            thead{
                background: #b7c0c3;
                color: black;
            }
            .barra{
                background: #193d72;
                color: white;
            }
            .modal-footer{
                background-color: #193d72;
            }
            center{
                background:  #333333;
                color: white;
            }
        </style>   


        <title>Ventas</title>

    </head>
    <body >
        <%
            Usuario u = (Usuario) session.getAttribute("usr");
            if (u != null) {
        %>
        <!-- Sidebar -->
        <jsp:include page="menu.jsp"/>
        <div class="container-fluid " ng-app="ventas" ng-controller="ventasController as v">
            <div  class="row">
                <div class="col-8">
                </div>
                <div class="sesion col-4" >
                        <div class=" row">
                            <div class="col-6">
                                <h3><svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                                    <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                                    <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                                    </svg> <%=u.getNombreDeUsuario()%></h3>
                            </div>
                            <div class="col-6">
                                <button type="button" class="btn btn-outline-info"   ng-click="v.cerrarSesion()">Cerrar Session
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-box-arrow-in-right" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M6 3.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 0-1 0v2A1.5 1.5 0 0 0 6.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-8A1.5 1.5 0 0 0 5 3.5v2a.5.5 0 0 0 1 0v-2z"/>
                                    <path fill-rule="evenodd" d="M11.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H1.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
                                    </svg>
                                </button> 
                            </div>
                        </div>
                    </div>
            </div>
            <!-- Page Content -->
                <div class="row">
                    <div class="col-12 mt-5">
                        <table class="table table-striped">
                            <thead >
                                <tr class="barra">
                                    <th scope="col" colspan="7" ><h3>VENTA DE PRODUCTOS</h3></th>
                                    <th scope="col" >
                                        <a data-toggle="modal" data-target="#modalGuardar">
                                            <button class="btn btn-primary">Hacer Venta</button>
                                        </a>

                                    </th>
                                </tr>
                                <tr>
                                    <th scope="col">Factura</th>
                                    <th scope="col">Fecha</th>
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Precio Producto</th>
                                    <th scope="col">Descripcion</th>
                                    <th scope="col">Cantidad Venta</th>
                                    <th scope="col">Total de venta</th>
                                    <th scope="col">Acciones</th>

                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="ve in v.Ventas">

                                    <td>{{ve.numFactura}}</td>
                                    <td>{{ve.fecha| date:'dd-MM-yyyy'}}</td>
                                    <td>{{ve.producto.nombreProducto}}</td>
                                    <td>{{ve.producto.precioProducto}}</td>
                                    <td>{{ve.producto.descripcion}}</td>
                                    <td>{{ve.cantidad}}</td>
                                    <td>{{ve.cantidad * ve.producto.precioProducto}}</td>

                                    <td>
                                        <a  ng-click="v.editar(ve.numFactura)" data-toggle="modal" data-target="#modalEditar">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                            <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                                            <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"/>
                                            </svg>
                                        </a>    
                                    </td>    
                                </tr>         
                            </tbody>    
                        </table>
                    </div>
                </div>  
             
                <!-- Modal editar-->
                <div class="modal fade" id="modalEditar" tabindex="-1" aria-labelledby="editarModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header " >
                                <h5 class="modal-title" id="editarModalLabel">ACTUALIZAR /// ELIMINAR </h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body" >
                                <div class="row">
                                    <div class="col-12">
                                        <label><h6>Fecha</h6></label>
                                        <input class="form-control" type="date"  placeholder="DD/MM/AAA"  ng-model="v.fecha">
                                    </div>
                                    
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <label><h6>Numero Factura</h6></label>
                                        <input class="form-control" type="Number"  disabled="" placeholder="Numero Factura"  ng-model="v.numFactura">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <label>Nombre Producto</label>
                                        <select class="form-control" ng-model="v.nomProducto">      
                                            <option  ng-repeat="p in v.Productos"  value="{{p.idProducto}}">{{p.nombreProducto}}</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <label><h6>Cantidad </h6></label>
                                        <input class="form-control" type="Number" placeholder="Cantidad" ng-model="v.cantidad">
                                    </div>
                                  
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-outline-danger" data-toggle="modal" data-target="#modalEliminar" >eliminar</button>
                                <button type="button" class="btn btn-outline-warning" data-toggle="modal" data-target="#modalActualizar" >Actualizar</button>
                            </div>
                        </div>  
                    </div>
                </div>   
                <!-- Modal guardar-->
                <div class="modal fade" id="modalGuardar" tabindex="-1" aria-labelledby="guardarModalLabel" aria-hidden="true" >
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title " id="guardarModalLabel">VENTA</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">

                                <div class="row">
                                    <div class="col-12">
                                        <label><h6>Fecha</h6></label>
                                        <input class="form-control" type="date"  placeholder="DD/MM/AAA"  ng-model="v.fecha">
                                    </div>
                                   
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <label><h6>Numero Factura</h6></label>
                                        <input class="form-control" type="Number" placeholder="Numero Factura"  disabled="" ng-model="v.numFactura">
                                    </div>
                                    
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <label>Nombre Producto</label>
                                        <select class="form-control" ng-model="v.nomProducto">      
                                            <option  ng-repeat="p in v.Productos"  value="{{p.idProducto}}">{{p.nombreProducto}}</option>
                                        </select>
                                    </div>
                                   
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <label><h6>Cantidad </h6></label>
                                        <input class="form-control" type="Number" placeholder="Cantidad" ng-model="v.cantidad">
                                    </div>
                                    
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                                <button type="button" class="btn btn-warning" data-dismiss="modal" ng-click="v.guardar()">Vender</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal Actualizar-->
                <div class="modal fade" id="modalActualizar" tabindex="-1" aria-labelledby="actualizarModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="actualizarModalLabel">¿Está seguro de Actualizar este registro?</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                El registro será Actualizado completamente de la base de datos
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                <button type="button" class="btn btn-primary" data-dismiss="modal" ng-click="v.actualizar()">Si</button>
                            </div>
                        </div>
                    </div>
                </div>      
                <!-- Modal eliminar-->
                <div class="modal fade" id="modalEliminar" tabindex="-1" aria-labelledby="eliminarModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="eliminarModalLabel">¿Está seguro de eliminar este registro?</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                El registro será eliminado completamente de la base de datos
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                <button type="button" class="btn btn-primary" data-dismiss="modal" ng-click="v.eliminar()">Si</button>
                            </div>
                        </div>
                    </div>
                </div>      
            </div>    
        </div>    


        <script>
            var app = angular.module('ventas', []);
            app.controller('ventasController', ['$http', controladorVentas]);
            function controladorVentas($http) {
                var v = this;
                validar = function (tipoDeValidacion) {
                    var numFactura = v.numFactura ? true : false;
                    var fecha = v.fecha ? true : false;
                    var nomProducto = v.nomProducto ? true : false;
                    var cantidad = v.cantidad ? true : false;

                    if (tipoDeValidacion === 'todosLosCampos') {
                        if (numFactura && fecha && nomProducto && cantidad) {
                            return true;
                        } else {
                            return false;
                        }
                    } else if (tipoDeValidacion === 'todosLosCamposSinFactura') {
                        if (fecha && nomProducto && cantidad) {
                            return true;
                        } else {
                            return false;
                        }
                    } else if (tipoDeValidacion === 'numFactura') {
                        if (numFactura) {
                            return true;
                        } else {
                            return false;
                        }
                    } else {
                        return false;
                    }

                };
                consultarProductos = function () {
                    var parametros = {
                        proceso: 'listar'
                    };
                    $http({
                        method: 'POST',
                        url: 'Peticiones/peticionesProducto.jsp',
                        params: parametros
                    }).then(function (res) {
                        v.Productos = res.data.Productos;
                    });
                };
                consultarProductos();
                v.listar = function () {
                    var parametros = {
                        proceso: 'listar'
                    };
                    $http({
                        method: 'POST',
                        url: 'Peticiones/peticionesVentas.jsp',
                        params: parametros

                    }).then(function (res) {
                        v.Ventas = res.data.Ventas;
                    });
                    
                };
                v.editar = function (numf) {
                    var parametros = {
                        proceso: 'consultarIndividual',
                        numFactura: numf
                    };
                    $http({
                        method: 'POST',
                        url: 'Peticiones/peticionesVentas.jsp',
                        params: parametros
                    }).then(function (res) {


                        v.fecha = res.data.Venta.fecha;
                        v.numFactura = res.data.Venta.numFactura;
                        v.nomProducto = res.data.Venta.nomProducto;
                        v.cantidad = res.data.Venta.cantidad;


                    });
                    
                };
                v.guardar = function () {
                    if (validar('todosLosCampos')) {
                        var parametros = {

                            proceso: 'guardar',

                            numFactura: v.numFactura,
                            fecha: v.fecha,
                            nomProducto: v.nomProducto,
                            cantidad: v.cantidad

                        };
                        $http({
                            method: 'POST',
                            url: 'Peticiones/peticionesVentas.jsp',
                            params: parametros
                        }).then(function (res) {
                            if (res.data.ok === true) {
                                if (res.data.guardar === true) {
                                    swal({
                                        title: "Guardo Exitosamente La Compra!",
                                        text: "!Exitoso!",
                                        icon: "success"
                                    });
                                    v.listar();
                                } else {
                                    swal({
                                        title: "Fallo la Compra !",
                                        text: "!Fallo Valide los datos !",
                                        icon: "error"
                                    });
                                }
                            } else {
                                alert(res.data.errorMsg);
                            }
                        });
                    } else {
                        swal({
                            title: "RELLENE LOS COMPOS!",
                            text: "!ALGO TE FALTA!",
                            icon: "info"
                        });
                    }
                };
                v.eliminar = function () {
                    if (validar('numFactura')) {
                        var parametros = {
                            proceso: 'eliminar',
                            numFactura: v.numFactura
                        };
                        $http({
                            method: 'POST',
                            url: 'Peticiones/peticionesVentas.jsp',
                            params: parametros

                        }).then(function (res) {
                            if (res.data.ok === true) {
                                if (res.data.eliminar === true) {
                                    swal({
                                        title: "elimino Exitosamente La Compra!",
                                        text: "!Exitoso!",
                                        icon: "success"
                                    });
                                    v.listar();
                                } else {
                                    swal({
                                        title: "Fallo en la eliminacion!",
                                        text: "!Fallo Valide los datos !",
                                        icon: "error"
                                    });
                                }
                            } else {
                                alert(res.data.errorMsg);
                            }

                        });
                    } else {
                        swal({
                            title: "RELLENE NUMERO DE FACTURA!",
                            text: "!ALGO TE FALTA!",
                            icon: "info"
                        });
                    }
                };
                v.actualizar = function () {
                    if (validar('todosLosCamposSinFactura')) {
                        var parametros = {
                            proceso: 'actualizar',
                            numFactura: v.numFactura,
                            fecha: v.fecha,
                            nomProducto: v.nomProducto,
                            cantidad: v.cantidad
                        };
                        $http({
                            method: 'POST',
                            url: 'Peticiones/peticionesVentas.jsp',
                            params: parametros

                        }).then(function (res) {
                            if (res.data.ok === true) {
                                if (res.data.actualizar === true) {
                                    swal({
                                        title: "Actualizacion  Exitosamente de  La Compra!",
                                        text: "!Exitoso!",
                                        icon: "success"
                                    });
                                    v.listar();
                                } else {
                                    swal({
                                        title: "Fallo La actualizacion!",
                                        text: "!Fallo Valide los datos !",
                                        icon: "error"
                                    });
                                }
                            } else {
                                alert(res.data.errorMsg);
                            }

                        });
                    } else {
                        swal({
                            title: "Rellene todos los compos Fallo La actualizacion!",
                            text: "!Fallo Valide los datos !",
                            icon: "info"
                        });
                    }

                };
                v.cerrarSesion = function () {
                        var parametros = {
                            proceso: 'cerrarSesion'
                        };
                        $http({
                            method: 'POST',
                            url: 'Peticiones/peticionesLogin.jsp',
                            params: parametros

                        }).then(function (res) {
                            if (res.data.ok === true) {
                                window.location.href="Login.html";
                            } else {
                                alert(res.data.errorMsg);
                            }
                            
                        });
                };
                v.listar();
            }


        </script>
        <%
        } else {%>
    <center><a href="Login.html"><h2>No se ha iniciado sesion o la sesion caduco,Click aca para ingresar</h2></a></center>     

    <%      }
    %>
</body> 

</html>
