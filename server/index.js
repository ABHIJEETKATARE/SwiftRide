console.log("hello");
const port=process.env.PORT || 3000;
const express=require("express");
const mongoose = require("mongoose");

//console.log(mongoose.version); 
const db="mongodb+srv://Abhijeet:854286@cluster0.nn0csyl.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";
const authRouter=require("./routes/auth");
const bookingRouter=require("./routes/booking");
// const adminRouter = require("./routes/admin");
// const productRouter = require("./routes/product");
// const userRouter=require("./routes/user");
// const admin = require("./middlewares/admin");
const app=express();
//middlewares
app.use(express.json());
mongoose.connect(db).then(()=>{console.log("successful")}).catch((e)=>{console.log(e)});
mongoose.load
app.use(authRouter);
// app.use(adminRouter);
 app.use(bookingRouter);
// app.use(userRouter);
app.listen(port,"0.0.0.0",()=>{console.log(`connected at port ${port}`);});
