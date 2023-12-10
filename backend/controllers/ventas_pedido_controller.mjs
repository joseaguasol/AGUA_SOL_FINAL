import modelPedido from "../models/ventas_pedido_model.mjs";

export const createPedidos = async (req,res) => {
    try {
        const newpedido = req.body
        const pedidocreado= await modelPedido.createPedido(newpedido);
        
        res.json(pedidocreado);
    } catch (error) {
        res.status(500).json({error:error.message});

    }
}

export const getLastPedidos = async (req,res) => {
    try{
        const getLast = await modelPedido.getLastPedido();
        res.json(getLast);
    }
    catch(e){
        res.status(500).json({error:e.message})
    }
}
