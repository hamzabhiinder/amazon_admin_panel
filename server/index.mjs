import express from "express";
import cors from "cors";
import { } from "./src/connection/db_connection.mjs";
import authRouter from "./src/routes/auth.mjs";

import morgan from 'morgan';



const app = express();
const port = 8000


app.use(cors())
app.use(morgan('dev'))
app.use(express.json())
app.use(authRouter)


app.listen(port, "0.0.0.0", () => {
    console.log(`Example app listening on port ${port} `)
})
