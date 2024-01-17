import { db_pool } from "../config.mjs";

const modelDetallePedido = {
    createDetallePedido: async (detalle) =>{
        try {
            console.log(".......modelo detalle_pedido   ");
            // Obtener el último ID de pedido
            const lastPedido = await db_pool.one('SELECT id FROM ventas.pedido WHERE cliente_id = $1 ORDER BY id DESC LIMIT 1',
             [detalle.cliente_id]);

            const detallepedido = await db_pool.one('INSERT INTO relaciones.detalle_pedido(pedido_id, producto_id, cantidad) VALUES($1, $2, $3) RETURNING *',
                [lastPedido.id, detalle.producto_id, detalle.cantidad]
            );

            return detallepedido;
        } catch (error) {
            throw new Error(`Error query create: ${error}`);
        }
    },
    getDetallePedido: async () => {
        try {
            const pedidos = await db_pool.any('SELECT * FROM relaciones.detalle_pedido')
            return pedidos
        } catch (error) {
            throw new Error(`Error query get: ${error}`);
        }
    }
}
export default modelDetallePedido;
