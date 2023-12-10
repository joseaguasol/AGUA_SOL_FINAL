import { createDetalle } from "../controllers/relacion_detallepedido_controller.mjs";

import express from 'express';

const routerDetallePedido = express.Router();

routerDetallePedido.post('/detallepedido',createDetalle)

export default routerDetallePedido