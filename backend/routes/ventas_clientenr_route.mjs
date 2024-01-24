import { createClientesnr,getClienteNR } from '../controllers/ventas_clientenr_controller.mjs';
import express from 'express';

const routerClienteNR = express.Router();

routerClienteNR.post('/clientenr',createClientesnr)
routerClienteNR.get('/clientenr',getClienteNR)




export default routerClienteNR;