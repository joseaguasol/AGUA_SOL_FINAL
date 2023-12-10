import { db_pool } from "../config.mjs";

const modelDetallePedido = {
    createDetallePedido: async (detalle) =>{
        try {
            console.log(".......modelo detalle_pedido   ");
            // Obtener el último ID de pedido
            const lastPedido = await db_pool.one('SELECT id FROM ventas.pedido WHERE cliente_id = $1 ORDER BY id DESC LIMIT 1', [detalle.clienteid]);

            const detallepedido = await db_pool.one('INSERT INTO relaciones.detalle_pedido(pedido_id, producto_id, fecha, cantidad, descripcion_general, descuento, precio_total) VALUES($1, $2, $3, $4, $5, $6, $7) RETURNING *',
                [lastPedido.id, detalle.producto_id, detalle.fecha, detalle.cantidad, detalle.descripcion_general, detalle.descuento, detalle.precio_total]
            );

            return detallepedido;
        } catch (error) {
            throw new Error(`Error query create: ${error}`);
        }
}
}
export default modelDetallePedido;