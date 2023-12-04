import express from "express";
import cors from 'cors';
import morgan from "morgan";
import routerClients from './routes/cliente_route.mjs';
import routerVentas from './routes/ventas_route.mjs';
import routerVehiculos from './routes/vehiculo_routes.mjs';
import routerRutas from './routes/ruta_route.mjs';
import routerProductos from './routes/producto_route.mjs';
/* AQUÍ VA LAS SIGUIENTES RUTAS*/
import routerAdmin from './routes/administrador_route.mjs';
import routerConductores from './routes/conductor_route.mjs';
import routerEmpleados from './routes/empleado_route.mjs';
import routerPedidos from './routes/pedido_route.mjs';
/* LAS NUEVAS RUTAS */
import routerUserAdmin from "./routes/user_admin_route.mjs";


/** INICIA LA APP Y EL PUERTO */
const app_sol = express();
const port = 8003;

app_sol.use(cors());
app_sol.use(express.json());
app_sol.use(morgan('combined'))

/** CONFIGURAMOS LAS RUTAS */
app_sol.use('/api',routerClients);
app_sol.use('/api',routerVentas);
app_sol.use('/api',routerVehiculos);
app_sol.use('/api',routerRutas);
app_sol.use('/api',routerProductos);
app_sol.use('/api',routerAdmin);
app_sol.use('/api',routerConductores);
app_sol.use('/api',routerEmpleados);
app_sol.use('/api',routerPedidos);

/** */
app_sol.use('/api',routerUserAdmin);

app_sol.listen(port, ()=>{
    console.log(`Servidor en: http://127.0.0.1:${port}`);
})
