import express from "express";
const productRouter = express.Router();
import auth from "../../middleware/auth.mjs";
import Product from "../Model/productModel.mjs";


productRouter.get('/api/products', auth, async (req, res) => {
    try {
        console.log(req.query.category);
        const product = await Product.find({ category: req.query.category });
        res.json(product);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
//create a get request to search product and get them

productRouter.get('/api/products/search/:name', auth, async (req, res) => {
    try {
        console.log(req.query.category);
        const product = await Product.find({
            name: { $regex: req.params.name, $options: "i" }
        });
        res.json(product);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});
export default productRouter;