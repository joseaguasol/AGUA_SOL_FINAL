import modelClientenr from "../models/ventas_clientenr_model.mjs";

export const createClientesnr = async (req,res) => {
    try {
        const newcliente = req.body
        const createcliente= await modelClientenr.createClientenr(newcliente);
        res.json(createcliente);
    } catch (error) {
        res.status(500).json({error:error.message});

    }
}
export const getClienteNR =  async (req,res) => {
    console.log("id llego")
    try {
        const getCliente = await modelClientenr.getClientenr();
        //console.log("----controller pedido")
       // console.log(getPedidos)
        res.json(getCliente)
    } catch (error) {
        res.status(500).json({erro:error.message})
    }
}