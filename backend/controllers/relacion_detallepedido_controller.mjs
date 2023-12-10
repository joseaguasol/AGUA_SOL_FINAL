import modelDetallePedido from "../models/relacion_detallepedido_model.mjs";

export const createDetalle = async (req,res) => {
    try {
        const newdetalle = req.body
        const detalleCreado= await modelDetallePedido.c(newdetalle);
        
        res.json(detalleCreado);
    } catch (error) {
        res.status(500).json({error:error.message});

    }
}

