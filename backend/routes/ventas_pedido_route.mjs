import { createPedidos, getLastPedidos, getPedidos, deletePedidos,updatePedidos, updateRutaPedidos} from '../controllers/ventas_pedido_controller.mjs';
import express from 'express';

const routerVentasPedido = express.Router();
routerVentasPedido.get('/pedido',getPedidos)
routerVentasPedido.post('/pedido',createPedidos)
routerVentasPedido.get('/pedido_last/:clienteID',getLastPedidos)
routerVentasPedido.delete('/pedido/:pedidoID', deletePedidos)
routerVentasPedido.put('/pedido/:pedidoID', updatePedidos)
routerVentasPedido.put('/pedidoruta/:pedidoID',updateRutaPedidos)


export default routerVentasPedido;
