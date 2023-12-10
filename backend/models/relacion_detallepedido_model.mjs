import { db_pool } from "../config.mjs";

const modelDetallePedido = {
    creaeDetallePedido: async (detalle) =>{
    try {
        const detallepedido = await db_pool.one('INSERT INTO relaciones.detalle_pedido(pedido_id,producto_id,fecha,descripcion_general,descuento,precio_total)VALUES($1,$2,$3,$4,$5,$6) RETURNING *',
        [detalle.detalle_pedido,detalle.producto_id,detalle.fecha,detalle.descripcion_general,detalle.descuento,detalle.precio_total])
        return detallepedido
    } catch (error) {
        throw new Error(`Error query create:${e}`)
    }
}
}
export default modelDetallePedido;