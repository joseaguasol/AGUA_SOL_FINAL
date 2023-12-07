import { db_pool } from "../config.mjs";

const modelProduct = {
    getProduct:async () => {
        try{
            const product = await db_pool.any('select * from ventas.producto');
            return product;
        }
        catch(e){
            throw new Error(`Error query create:${e}`);
        }
    },
}

export default modelProduct;