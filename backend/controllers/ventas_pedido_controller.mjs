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

export const getPedidos =  async (req,res) => {
    console.log("id llego")
    try {
        const getPedidos = await modelPedido.getPedido();
        res.json(getPedidos)
    } catch (error) {
        res.status(500).json({erro:error.message})
    }
}

export const deletePedidos = async (req,res) => {
    console.log("id llego")
    try {
        const { pedidoID } = req.params;
        const id = parseInt(pedidoID, 10);
        const deleteResult = await modelPedido.deletePedido(id);

        if (deleteResult) {
            res.json({ mensaje: 'El pedido ha sido eliminado exitosamente' });
        } else {
            // Si rowCount no es 1, significa que no se encontró un cliente con ese ID
            res.status(404).json({ error: 'No se encontró la ruta con el ID proporcionado' });
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

export const updatePedidos = async (req,res)=>{
    try {
        const {pedidoID} = req.params;
        const id = parseInt(pedidoID,10);
        const data = req.body;
        const updatePedidos = await modelPedido.updatePedido(id,data);
        res.json(updatePedidos);
    } catch (error) {
        res.status(500).json({error:error.message});
    }
}

export const updateRutaPedidos = async(req,res)=>{
    try {
        // EXTRAYENDO EL ID DE LA RUTA
        const {pedidoID} = req.params
        const idpedido =parseInt(pedidoID,10)
        console.log("idpedido")
        console.log(idpedido)

        // EXTRAYENDO EL BODY 
        const ruta = req.body
        const updaterutapedido = await modelPedido.updateRutaPedido(idpedido,ruta)
        res.json(updaterutapedido)

    } catch (error) {
        res.status(500).json({error:error.message})
    }
}
