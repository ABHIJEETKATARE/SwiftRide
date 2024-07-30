const mongoose=require("mongoose");
const ratingSchema=require("./rating")
const locationSchema=require("./location")
const driverSchema=mongoose.Schema({
    name:{
        type:String,
        trim:true,
        required:true
    },
    carModel:{
        type:String,
        trim:true,
        required:true
    },
    location:{
        type:locationSchema,
        required:true
    },

    availability:{
        type:Boolean,
        required:true
    },
rating:{
    type:Number,
}
});
const Drivers=mongoose.model("Drivers",driverSchema);
module.exports={Drivers,driverSchema};