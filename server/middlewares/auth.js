const jwt=require("jsonwebtoken");

const auth=async(req,res,next)=> {
    try{
        const token=req.header("x-auth-token");// every time when we have to perform authorization we use auth middleware
        if(!token)
            return res.status(401).json({msg:"No auth token,access denied"});
        const verified=jwt.verify(token,"passwordKey");
        if(!verified)
            return res.status(401).json({msg:"Token verification failed,authorization denied."});
        req.user=verified.id; // if valid then we are storing user ID in req.user
        req.token=token;
        next();// next basically means that it can call the next callback function 
    }
    catch(err){
        res.status(500).json({error:err.message});
    }
};
module.exports=auth;