import { db_pool } from "../config.mjs";
import { io } from '../index.mjs';
import {Server} from "socket.io";


const modelPedido = {
    createPedido:async (pedido) => {
        try{

           // const io = await app_sol.get('io');

            const pedidos = await db_pool.one('INSERT INTO ventas.pedido (cliente_id,monto_total,fecha,tipo,estado) VALUES ($1,$2,$3,$4,$5) RETURNING *',
            [pedido.cliente_id,pedido.monto_total,pedido.fecha,pedido.tipo,pedido.estado]);
            
           // const io = app_sol.get(io);
            //EMITIR UN EVENTO
            io.emit('nuevoPedido',pedidos)

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
    },
    getPedido: async ()=> {
        try {
            const pedidos = await db_pool.any('SELECT * FROM ventas.pedido');
            return pedidos

        } catch (error) {
            throw new Error(`Error getting pedido: ${error}`)
        }
    }
}

export default modelPedido;
