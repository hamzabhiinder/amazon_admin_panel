import express from "express";
const adminRouter = express.Router();

import admin from "../../middleware/admin.mjs";
import { Product } from "../Model/productModel.mjs";
import Order from "../Model/orderModel.mjs";


//Add Product
adminRouter.post('/admin/add-products', admin, async (req, res) => {
    try {
        const { name, description, price, quantity, category, images } = req.body

        let product = new Product(
            {
                name, description, price, quantity, category, images,
            });
        res.json(product);
        product = await product.save();
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
})
///get all product 
adminRouter.get('/admin/get-products', admin, async (req, res) => {
    try {
        const product = await Product.find({});
        res.send(product);
        // res.status(200).json(product);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
})



///delete specific product
adminRouter.post('/admin/delete-product', admin, async (req, res) => {
    try {
        const { id } = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);

    } catch (error) {
        res.status(500).json({ error: error.message });

    }
})


adminRouter.get('/admin/get-orders', admin, async (req, res) => {
    try {
        const order = await Order.find();
        res.json(order);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

adminRouter.post('/admin/change-order-status', admin, async (req, res) => {
    try {
        const { id, status } = req.body;
        let order = await Order.findById(id);
        order.status = status;
        await order.save();
        res.json(order);

    } catch (error) {
        res.status(500).json({ error: error.message });

    }
})


adminRouter.get('/admin/analytics', admin, async (req, res) => {
    try {
        const order = await Order.find();
        let totalEarnings = 0;

        for (let i = 0; i < order.length; i++) {
            for (let j = 0; j < order[i].products.length; j++) {
                totalEarnings += order[i].products[j].quantity * order[i].products[j].product.price;
            }
        }
        ////////CATEGY WISE PRODUCTS/////
        let mobileEarning = fetchCategoryWiseProduct("Mobiles");
        let EssentialEarning = fetchCategoryWiseProduct("Essentials");
        let ApplianceEarning = fetchCategoryWiseProduct("Appliances");
        let BookEarning = fetchCategoryWiseProduct("Books");
        let FashionEarning = fetchCategoryWiseProduct("Fashion");

        let earning = {
            totalEarnings,
            mobileEarning,
            EssentialEarning,
            ApplianceEarning,
            BookEarning,
            FashionEarning,
        }
        res.json(earning);

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
})


const fetchCategoryWiseProduct = async (category) => {
    let earning = 0;
    let categoryOrder = await Order.find({
        'products.product.category': category,
    });
    for (let i = 0; i < categoryOrder.length; i++) {
        for (let j = 0; j < categoryOrder[i].products.length; j++) {
            earning +=
                categoryOrder[i].products[j].quantity *
                categoryOrder[i].products[j].product.price;
        }
    }
    return earning;
}
export default adminRouter;