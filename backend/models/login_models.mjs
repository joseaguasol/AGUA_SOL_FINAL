import { db_pool } from "../config.mjs";

const modelLogin = {
    Login:async (credenciales) => {
        try{
            const administrador = await db_pool.any('select * from personal.usuario inner join personal.administrador'+
            ' on personal.usuario.id = personal.administrador.usuario_id'+
            ' where nickname=$1 and contrasena=$2',
            [credenciales.nickname,credenciales.contrasena]);

            const conductor = await db_pool.any('select * from personal.usuario inner join personal.conductor'+
            ' on personal.usuario.id = personal.conductor.usuario_id'+
            ' where nickname=$1 and contrasena=$2',
            [credenciales.nickname,credenciales.contrasena]);

            const empleado = await db_pool.any('select * from personal.usuario inner join personal.empleado'+
            ' on personal.usuario.id = personal.empleado.usuario_id'+
            ' where nickname=$1 and contrasena=$2',
            [credenciales.nickname,credenciales.contrasena]);

            const superadmin = await db_pool.any('select * from personal.usuario inner join personal.superadmin'+
            ' on personal.usuario.id = personal.superadmin.usuario_id'+
            ' where nickname=$1 and contrasena=$2',
            [credenciales.nickname,credenciales.contrasena]);

            const cliente = await db_pool.any('select * from personal.usuario inner join ventas.cliente'+
            ' on personal.usuario.id = ventas.cliente.usuario_id'+
            ' where nickname=$1 and contrasena=$2',
            [credenciales.nickname,credenciales.contrasena]);

            if(administrador){
                console.log("ad min--->:",administrador)
                return {rol_user:administrador[0].rol_id}
            }
            else if(conductor){
                return {rol_user:conductor[0].rol_id}
            }
            else if(empleado){
                return {rol_user:empleado[0].rol_id}
            }
            else if(superadmin){
                return {rol_user:superadmin[0].rol_id}
            }
            else if(cliente){
                return {rol_user:cliente[0].rol_id}
            }
            else{
                return null
            }

        }
        catch(e){
            throw new Error(`Error query create:${e}`)
        }
    },
}

export default modelLogin;