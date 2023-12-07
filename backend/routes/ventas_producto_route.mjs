import { getAllProduct } from '../controllers/ventas_producto_controller.mjs';
import express from 'express';

const routerVentasProduct = express.Router();

routerVentasProduct.get('/products',getAllProduct)




export default routerVentasProduct;