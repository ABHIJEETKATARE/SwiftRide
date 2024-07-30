const mongoose=require("mongoose");
const {driverSchema}=require("./driver")
const bookingSchema=mongoose.Schema({
    status:{
        type:String,
        trim:true,
        required:true
    },
    driver:{
        type:driverSchema,
        //required:true,
    },
    estimatedArrivalTime:{
        type:String,
        trim:true,
        required:true
    }
});
const Bookings=mongoose.model("Bookings",bookingSchema);
module.exports=bookingSchema;