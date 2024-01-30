import { getAllProducts,getONEProducts,getProductsPorPromos } from '../controllers/ventas_producto_controller.mjs';
import express from 'express';

const routerVentasProduct = express.Router();

routerVentasProduct.get('/products',getAllProducts),
routerVentasProduct.get('/products/:productID',getONEProducts)
routerVentasProduct.get('/productsbypromo/:promocionId',getProductsPorPromos)






export default routerVentasProduct;
