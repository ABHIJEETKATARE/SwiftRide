const express=require("express")//import statement
const rideBookingRouter=express.Router();
const User=require("../models/user");
const locationSchema = require("../models/location");
const {Drivers} = require('../models/driver');
const bookingSchema=require('../models/booking');
const auth = require("../middlewares/auth");
rideBookingRouter.post("/api/book-ride/",auth,async(req,res)=>{
  try{
    const {id} =req.body;
    const drivers=await Drivers.find();
    
    let booking={
        status:"failure",
        driver:null,
        estimatedArrivalTime:""
    }
    for (let index = 0; index < drivers.length; index++) {
        if(drivers[index].availability)
        {
            let driverr={
                _id:drivers[index]._id,
                name:drivers[index].name,
                carModel:drivers[index].carModel,
                availability:drivers[index].availability,
                location:{
                    latitude:drivers[index].location.latitude,
                    longitude:drivers[index].location.longitude
                },
                rating:drivers[index].rating

            }
            booking={
                status:"success",
                driver:driverr,
                estimatedArrivalTime:"5 minutes"
            }
        }
        
    }
    res.json(booking);
    }
    catch(e)
    {
        res.status(500).json({console:e.message});
    }
})
module.exports=rideBookingRouter;