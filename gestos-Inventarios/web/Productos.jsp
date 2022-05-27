<%-- 
    Document   : Productos
    Created on : 21/11/2021, 09:15:20 PM
    Author     : black
--%>

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
        <title>Productos</title>

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
    </head>
    <body >
        <%
            Usuario u = (Usuario) session.getAttribute("usr");
            if (u != null) {
        %>
        <div  ng-app="productos" ng-controller="productosController as p">

            <!-- Sidebar -->
            <!-- Sidebar -->
            <jsp:include page="menu.jsp"/>
            <!-- Page Content -->
            <div >
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
                                <button type="button" class="btn btn-outline-info"   ng-click="p.cerrarSesion()">Cerrar Session
                                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-box-arrow-in-right" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M6 3.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 0-1 0v2A1.5 1.5 0 0 0 6.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-8A1.5 1.5 0 0 0 5 3.5v2a.5.5 0 0 0 1 0v-2z"/>
                                    <path fill-rule="evenodd" d="M11.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H1.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
                                    </svg>
                                </button> 
                            </div>
                        </div>
                    </div>
                </div>
               
                <div class="row container-fluid">
                    <div class="col-12 mt-5">

                        <table class="table table-striped">
                            <thead >
                                <tr class="barra">
                                    <th scope="col" colspan="5"><h3>IVENTARIO DE PRODUCTOS</h3></th>
                                    <th scope="col">
                                        <a data-toggle="modal" data-target="#modalGuardar">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-cart-plus" viewBox="0 0 16 16">
                                            <path d="M9 5.5a.5.5 0 0 0-1 0V7H6.5a.5.5 0 0 0 0 1H8v1.5a.5.5 0 0 0 1 0V8h1.5a.5.5 0 0 0 0-1H9V5.5z"/>
                                            <path d="M.5 1a.5.5 0 0 0 0 1h1.11l.401 1.607 1.498 7.985A.5.5 0 0 0 4 12h1a2 2 0 1 0 0 4 2 2 0 0 0 0-4h7a2 2 0 1 0 0 4 2 2 0 0 0 0-4h1a.5.5 0 0 0 .491-.408l1.5-8A.5.5 0 0 0 14.5 3H2.89l-.405-1.621A.5.5 0 0 0 2 1H.5zm3.915 10L3.102 4h10.796l-1.313 7h-8.17zM6 14a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm7 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/>
                                            </svg>
                                        </a>

                                    </th>
                                </tr>
                                <tr>
                                    
                                    <th scope="col">Nombre</th>
                                    <th scope="col">Stop</th>
                                    <th scope="col">Precio</th>
                                    <th scope="col">Provedor</th>
                                    <th scope="col">Descripcion</th>
                                    <th scope="col">Acciones</th>

                                </tr>
                            </thead>
                            <tbody>
                                <tr ng-repeat="pro in p.Productos">

                                    
                                    <td>{{pro.nombreProducto}}</td>
                                    <td>{{pro.Stop}}</td>
                                    <td>{{pro.precioProducto}}</td>
                                    <td>{{pro.provedor.nombreProvedorPk}}</td>
                                    <td>{{pro.descripcion}}</td>
                                    <td>
                                        <a  ng-click="p.editar(pro.idProducto)" data-toggle="modal" data-target="#modalEditar">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
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
            </div>
            <!-- Modal editar-->
            <div class="modal fade" id="modalEditar" tabindex="-1" aria-labelledby="editarModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editarModalLabel">ACTUALIZAR /// ELIMINAR</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-4">
                                    <label>Id</label>
                                    <input class="form-control" type="number" disabled="" ng-model="p.Producto.idProducto">
                                </div>
                                <div class="col-8">
                                    <label>Nombre </label>
                                    <input class="form-control" type="text"  ng-model="p.Producto.nombreProducto">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <label>Stop</label>
                                    <input class="form-control" type="number" ng-model="p.Producto.Stop">
                                </div>
                                <div class="col-6">
                                    <label>Precio</label>
                                    <input class="form-control" type="number"  ng-model="p.Producto.precioProducto">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-8">
                                    <label>Descripción</label>
                                    <textarea class="form-control" type="text"  ng-model="p.Producto.descripcion"></textarea>
                                </div>
                                <div class="col-4">
                                    <label>Provedor</label>
                                    <input class="form-control" type="number" disabled="" ng-model="p.Producto.Provedor">
                                </div>    
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-outline-danger" data-toggle="modal" data-target="#modalEliminar" >eliminar</button>
                            <button type="button" class="btn btn-outline-info" data-toggle="modal" data-target="#modalActualizar" >Actualizar</button>
                        </div>
                    </div>  
                </div>
            </div>   
            <!-- Modal guardar-->
            <div class="modal fade" id="modalGuardar" tabindex="-1" aria-labelledby="guardarModalLabel" aria-hidden="true" >
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title " id="guardarModalLabel">INGRESO DE PRODUCTOS</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                
                                <div class="col-12">
                                    <label>Nombre</label>
                                    <input class="form-control" type="text" ng-model="p.nombreProducto">
                                </div>
                            </div>                  
                            <div class="row">
                                <div class="col-4">
                                    <label>Provedor</label>
                                    <select class="form-control"  ng-model="p.Provedor">
                                        <option ng-repeat="pro in p.Provedores"  value="{{pro.idProvedor}}"> {{pro.nombreProvedorPk}}</option>
                                    </select>
                                </div>
                                <div class="col-4">
                                    <label>Precio</label>
                                    <input class="form-control" type="number" ng-model="p.precioProducto">
                                </div>
                                <div class="col-4">
                                    <label>Stop</label>
                                    <input class="form-control" type="number" ng-model="p.Stop">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <label>Descrpición</label>
                                    <textarea class="form-control" ng-model="p.descripcion"></textarea>
                                </div>
                            </div>
                            <div class="row">

                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-dismiss="modal">Cancelar</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" ng-click="p.guardar()">ingresar</button>
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
                            <button type="button" class="btn btn-primary" data-dismiss="modal" ng-click="p.actualizar()">Si</button>
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
                            <button type="button" class="btn btn-primary" data-dismiss="modal" ng-click="p.eliminar()">Si</button>
                        </div>
                    </div>
                </div>
            </div>      
        </div>    
        <script>

            var app = angular.module('productos', []);
            app.controller('productosController', ['$http', controladorProductos]);
            function controladorProductos($http) {
                var p = this;
                p.listar = function () {
                    var parametros = {
                        proceso: 'listar'
                    };
                    $http({
                        method: 'POST',
                        url: 'Peticiones/peticionesProducto.jsp',
                        params: parametros
                    }).then(function (res) {
                        p.Productos = res.data.Productos;
                    });
                };
                p.eliminar = function () {
                    var parametros = {
                        proceso: 'eliminar',
                        idProducto: p.Producto.idProducto
                    };
                    $http({
                        method: 'POST',
                        url: 'Peticiones/peticionesProducto.jsp',
                        params: parametros
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data.eliminar === true) {
                                swal({
                                    title: "elimino Exitosamente La Compra!",
                                    text: "!Exitoso!",
                                    icon: "success"
                                });
                                p.listar();
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

                };
                p.guardar = function () {
                    var parametros = {
                        proceso: 'guardar',
                        idProducto: p.idProducto,
                        nombreProducto: p.nombreProducto,
                        Stop: p.Stop,
                        precioProducto: p.precioProducto,
                        descripcion: p.descripcion,
                        Provedor: p.Provedor
                    };
                    $http({
                        method: 'POST',
                        url: 'Peticiones/peticionesProducto.jsp',
                        params: parametros
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data.guardar === true) {
                                swal({
                                    title: "Guardo Exitosamente La Compra!",
                                    text: "!Exitoso!",
                                    icon: "success"
                                });
                            p.listar();    
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

                };
                consultarProvedor = function () {
                    var parametros = {
                        proceso: 'listar'
                    };
                    $http({
                        method: 'POST',
                        url: 'Peticiones/peticionesProvedores.jsp',
                        params: parametros
                    }).then(function (res) {
                        p.Provedores = res.data.Provedores;
                    });
                };
                consultarProvedor();
                p.editar = function (idPro) {
                    var parametros = {
                        proceso: 'consultarIndividual',
                        idProducto: idPro
                    };
                    $http({
                        method: 'POST',
                        url: 'Peticiones/peticionesProducto.jsp',
                        params: parametros
                    }).then(function (res) {
                        p.Producto = res.data.Producto;
                    });
                     p.listar();
                };
                p.actualizar = function () {
                    var parametros = {
                        proceso: 'actualizar',

                        idProducto: p.Producto.idProducto,
                        nombreProducto: p.Producto.nombreProducto,
                        Stop: p.Producto.Stop,
                        precioProducto: p.Producto.precioProducto,
                        descripcion: p.Producto.descripcion,
                        Provedor: p.Producto.Provedor
                    };
                    $http({
                        method: 'POST',
                        url: 'Peticiones/peticionesProducto.jsp',
                        params: parametros
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data.actualizar === true) {
                                swal({
                                    title: "Actualizacion  Exitosamente de  La Compra!",
                                    text: "!Exitoso!",
                                    icon: "success"
                                });
                                p.listar();
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

                };
                p.cerrarSesion = function () {
                    var parametros = {
                        proceso: 'cerrarSesion'
                    };
                    $http({
                        method: 'POST',
                        url: 'Peticiones/peticionesLogin.jsp',
                        params: parametros

                    }).then(function (res) {
                        if (res.data.ok === true) {
                            window.location.href = "Productos.jsp";
                        } else {
                            alert(res.data.errorMsg);
                        }

                    });
                };
                p.listar();
            }
        </script>
        <%
        } else {%>
     <center><a href="Login.html"><h2>No se ha iniciado sesion o la sesion caduco,Click aca para ingresar</h2></a></center>     

    <%      }
    %>
</body>
</html> 

