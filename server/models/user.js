const mongoose = require("mongoose");
//const {productSchema}=require("./product");
const locationSchema=require("./location.js")
const userSchema=mongoose.Schema({
    name:{
        type:String,
        trim:true,
        required:true
    },
    email:{
        type:String,
        requried:true,
       validate:{ validator:(value)=>{
            const regex=/^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
            return value.match(regex)
        }, 
        message:"enter valid email"}
    },
    password:{
        type:String,
        required:true,
        validate:{
            validator:(value)=>{
                return value.length>6;
            },
            message:"weak_password"
        }
    },
    location:{
        type:locationSchema,
        default:""
    },
    type:{
        type:String,
        default:""
    },
})
const user=mongoose.model("User",userSchema);
module.exports=user;
