import modelProduct from "../models/ventas_producto_model.mjs";

export const getAllProduct = async (req,res) => {
    try {
        const allproduct= await modelProduct.getProduct();
        res.json(allproduct);
    } catch (error) {
        res.status(500).json({error:error.message});

    }
}
