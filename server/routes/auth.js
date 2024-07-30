const express=require("express")//import statement
const authRouter=express.Router();
const User=require("../models/user");
const bcryptjs=require("bcryptjs");
const jwt=require("jsonwebtoken");
const user = require("../models/user");
const auth = require("../middlewares/auth");
const {Drivers}=require("../models/driver");
authRouter.post("/api/signUp",async(req,res)=>{
    try
    {const {name,email,password}=req.body;
    const ifexist=await User.findOne({email})
    if(ifexist)
    { 
        return res.status(400).json({message:"email already exist"});
    }
    const hashedPassword=await bcryptjs.hash(password,8);
    let user=new User({name,email,password:hashedPassword});
    user=await user.save();
     res.status(200).json(user);
}
catch(e){res.status(500).json({error:e.message})}    
    
}
);
authRouter.post("/api/signIn",async(req,res)=>{
    try
    {const {email,password}=req.body;
    const signInUser=await User.findOne({email})
    if(!signInUser)
    { 
        return res.status(400).json({message:"email does not exist"});
    }
    isvalidpassword = await bcryptjs.compare(password,signInUser.password)
    if(!isvalidpassword)
    {
        return res.status(400).json({message:"password didnt matched"});
    }
     const token=jwt.sign({id:signInUser._id},"passwordKey")
     res.status(200).json({token,...signInUser._doc});
    }
catch(e){res.status(500).json({error:e.message})}    

}
)
authRouter.get('/tokenIsValid',async(req,res)=>{
   try
    { token=req.header("x-auth-token");
    verified=jwt.verify(token,"passwordKey")
    if(!verified)
    return res.json(false);
const user=await User.findById(verified.id);
if(!user)
return res.json(false);
res.json(true);}
catch(e){
    res.json({error:e.message});
}

})
authRouter.get('/',async(req,res)=>{
    token=req.header('x-auth-token');
    verified=jwt.verify(token,"passwordKey");
    const user = await User.findById(verified.id);
    res.json({ ...user._doc, token });
});
authRouter.get("/api/get-drivers",auth,async(req,res)=>{
    try{const drivers=await Drivers.find({});
        
    res.json(drivers);}
    catch(e){
        res.status(500).json({msg:e.message})
    }
})


module.exports=authRouter; 
