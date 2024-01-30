import { db_pool } from "../config.mjs";
import bcrypt from 'bcrypt';

const modelLogin = {
    Login: async (credenciales) => {
        console.log("credenciales")
        console.log(credenciales)
        try {
            const tiposUsuarios = [
                { tipo: 'cliente', consulta: 'ventas.cliente' },
                { tipo: 'conductor', consulta: 'personal.conductor' },
                { tipo: 'empleado', consulta: 'personal.empleado' },
                { tipo: 'gerente', consulta: 'personal.gerente' },
                { tipo: 'administrador', consulta: 'personal.administrador' },
            ];

            for (const { tipo, consulta } of tiposUsuarios) {
                const resultado = await db_pool.oneOrNone(
                    `SELECT personal.usuario.id,personal.usuario.nickname,personal.usuario.email,personal.usuario.contrasena FROM personal.usuario 
                    INNER JOIN ${consulta} ON personal.usuario.id = ${consulta}.usuario_id 
                    WHERE nickname=$1`,// AND contrasena=$2`,
                    [credenciales.nickname]
                );
                console.log("resul del for")
                console.log(resultado)
                console.log('Resultado de la comparación de contraseñas:', await bcrypt.compare(credenciales.contrasena, resultado.contrasena));

               if (resultado && await bcrypt.compare(credenciales.contrasena, resultado.contrasena)) {
                console.log(`${tipo}--->:`, resultado);
                return {usuario:resultado}

                }
            }

            // Si no se encuentra en ninguna consulta
            return {"message":"Usuario no encontrado ni asociado"};
        } catch (e) {
            throw new Error(`Error en la consulta de inicio de sesión: ${e}`);
        }
    },
}

export default modelLogin;

