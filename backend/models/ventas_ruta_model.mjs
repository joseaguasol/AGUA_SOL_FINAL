import { db_pool } from "../config.mjs";
import { io } from '../index.mjs';



const modelRuta = {
    createRuta:async (ruta) => {
        try{
            console.log("model_ruta")
            console.log(ruta)
           // const io = await app_sol.get('io');

            const rutas = await db_pool.one('INSERT INTO ventas.ruta (conductor_id,empleado_id,distancia_km,tiempo_ruta,administrador_id,zona_trabajo_id) VALUES ($1,$2,$3,$4,$5,$6) RETURNING *',
            [ruta.conductor_id,ruta.empleado_id,ruta.distancia_km,ruta.tiempo_ruta,ruta.administrador_id,ruta.zona_trabajo_id]);
            
           // const io = app_sol.get(io);
            //EMITIR UN EVENTO
         //   io.emit('nuevoPedido',pedidos)
            console.log("rutas")
            console.log(rutas)
            return rutas

        }
        catch(e){
            throw new Error(`Error query create:${e}`)
        }
    },
    getLastRuta:async (empleado_id) => {
        try {
            const lastRuta =  await db_pool.one('SELECT id FROM ventas.ruta WHERE empleado_id = $1 ORDER BY id  DESC LIMIT 1',
            [empleado_id])
            console.log("ultima ruta")
            console.log(lastRuta)
            return lastRuta
        } catch (error) {
            throw new Error(`Error query create:${error}`)
        }
    }
    
}
export default modelRuta;