import { createPedidos, getLastPedidos } from '../controllers/ventas_pedido_controller.mjs';
import express from 'express';

const routerVentasPedido = express.Router();

routerVentasPedido.post('/pedido',createPedidos)
routerVentasPedido.get('/pedido_last',getLastPedidos)




export default routerVentasPedido;