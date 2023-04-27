import express from "express";
const userRouter = express.Router();
import auth from "../../middleware/auth.mjs";
import { Product } from "../Model/productModel.mjs";
import User from "../Model/userModel.mjs";


//Add Product
userRouter.post('/api/add-to-cart', auth, async (req, res) => {
    try {
        const { id } = req.body
        const product = await Product.findById(id)
        let user = await User.findById(req.user)
        if (user.cart.length == 0) {
            user.cart.push({ product, quantity: 1 });
        } else {
            let isProdctFound = false;
            for (let i = 0; i < user.cart.length; i++) {
                if (user.cart[i].product._id.equals(product._id)) {
                    isProdctFound = true;
                }
            }

            if (isProdctFound) {
                let productFind = user.cart.find((element) => element.product._id.equals(product._id));
                productFind.quantity += 1;
            } else {
                user.cart.push({ product, quantity: 1 });
            }
        }
        user = await user.save();
        res.json(user);

    } catch (error) {
        console.log(error);
        res.status(500).json({ error: error.message });
    }
})

export default userRouter;