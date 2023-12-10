import { db_pool } from "../config.mjs";

const modelPedido = {
    createPedido:async (pedido) => {
        try{
            const pedidos = await db_pool.one('INSERT INTO ventas.pedido (cliente_id,monto_total,fecha,direccion) VALUES ($1,$2,$3,$4) RETURNING *',
            [pedido.cliente_id,pedido.monto_total,pedido.fecha,pedido.direccion]);
            
            return pedidos

        }
        catch(e){
            throw new Error(`Error query create:${e}`)
        }
    },
    getLastPedido: async () => {
        try {
            const lastPedido = await db_pool.one('SELECT id FROM ventas.pedido ORDER BY id DESC LIMIT 1');
            return lastPedido;
        } catch (e) {
            throw new Error(`Error getting last pedido: ${e}`);
        }
    }
}

export default modelPedido;