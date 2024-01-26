import { db_pool } from "../config.mjs";
import { io } from '../index.mjs';



const modelClientenr = {
    createClientenr:async (clientenr) => {
        try{
      
          console.log("-----Cliente INSERTADO-------")

            const clientenrs = await db_pool.one('INSERT INTO ventas.cliente_noregistrado (nombre,apellidos,direccion,telefono,email,distrito,RUC) VALUES ($1,$2,$3,$4,$5,$6,$7) RETURNING *',
            [clientenr.nombre,clientenr.apellidos,clientenr.direccion,clientenr.telefono,clientenr.email,clientenr.distrito,clientenr.ruc]);
            
            await db_pool.one(`INSERT INTO relaciones.ubicacion (latitud,longitud,direccion,cliente_nr_id,distrito)
            VALUES($1,$2,$3,$4,$5)`,[clientenr.latitud,clientenr.longitud,clientenr.direccion,clientenrs.id,clientenr.distrito])

           console.log("CLIENTENR")
           console.log(clientenr)
           

            return clientenrs

        }
        catch(e){
            throw new Error(`Error query create:${e}`)
        }
    },
    getClientenr:async () =>{
        try {
            const clientenr = await db_pool.any('SELECT * FROM ventas.cliente_noregistrado')
            return clientenr
        } catch (error) {
            throw new Error(`Error query get:${e}`)
        }
    }

}

export default modelClientenr;