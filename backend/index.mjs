import express from "express";
import cors from 'cors';
import morgan from "morgan";
import routerVentasPedido from "./routes/ventas_pedido_route.mjs";
import routerUserConductor from "./routes/usuario_conductor_route.mjs";
import routerUserEmpleado from "./routes/usuario_empleado_route.mjs";
import routerUserCliente from "./routes/usuario_cliente_route.mjs";
import routerUserAdmin from "./routes/usuario_administrador_route.mjs";
import routerLogin from "./routes/login_route.mjs";
import routerVentasProduct from "./routes/ventas_producto_route.mjs";
import routerDetallePedido from "./routes/relaciones_detallepedido_route.mjs";

/** INICIA LA APP Y EL PUERTO */
const app_sol = express();
const port = 8004;

app_sol.use(cors());
app_sol.use(express.json());
app_sol.use(morgan('combined'))

/** CONFIGURAMOS LAS RUTAS */
app_sol.use('/api',routerUserAdmin);
app_sol.use('/api',routerUserCliente);
app_sol.use('/api',routerUserEmpleado);
app_sol.use('/api',routerUserConductor);
app_sol.use('/api',routerVentasProduct);
app_sol.use('/api',routerLogin);
app_sol.use('/api',routerVentasPedido);
app_sol.use('/api',routerDetallePedido);

app_sol.listen(port, ()=>{
    console.log(`Servidor en: http://127.0.0.1:${port}`);
})
