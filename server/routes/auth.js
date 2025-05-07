// const express = require("express");
// const authRouter = express.Router();
// const User = require("../models/user");
// const bcryptjs = require("bcryptjs");
// const jwt = require("jsonwebtoken");
// const auth = require("../middlewares/auth");

// // SIGNUP API - Role-Based User Registration
// authRouter.post("/api/signup", async (req, res) => {
//     try {
//         const { name, email, password, role } = req.body;

//         // Validate required fields
//         if (!name || !email || !password || !role) {
//             return res.status(400).json({ msg: "All fields are required" });
//         }

//         // Validate role
//         if (role !== "Doctor" && role !== "Patient") {
//             return res.status(400).json({ msg: "Invalid role. Choose 'Doctor' or 'Patient'." });
//         }

//         // Check if user already exists
//         const existingUser = await User.findOne({ email });
//         if (existingUser) {
//             return res.status(400).json({ msg: "User with this email already exists" });
//         }

//         // Hash the password
//         const hashedPassword = await bcryptjs.hash(password, 8);

//         // Create new user
//         let user = new User({
//             name,
//             email,
//             password: hashedPassword,
//             role
//         });

//         user = await user.save();

//         res.json({ _id: user._id, name: user.name, email: user.email, role: user.role });

//     } catch (e) {
//         res.status(500).json({ error: e.message });
//     }
// });


// // SIGNIN API - Role-Based Login
// authRouter.post("/api/signin", async (req, res) => {
//     try {
//         const { email, password } = req.body;

//         const user = await User.findOne({ email });
//         if (!user) {
//             return res.status(400).json({ msg: "User with this email does not exist!" });
//         }

//         // Compare passwords
//         const isMatch = await bcryptjs.compare(password, user.password);
//         if (!isMatch) {
//             return res.status(400).json({ msg: "Incorrect password." });
//         }

//         const token = jwt.sign({ id: user._id }, "passwordKey");

//         res.json({
//             token,
//             _id: user._id,
//             name: user.name,
//             email: user.email,
//             role: user.role // Send role in response
//         });

//     } catch (e) {
//         res.status(500).json({ error: e.message });
//     }
// });

// //Checking api is valid or not
// authRouter.post("/tokenIsvalid",async(req,res)=>{
//     try {
//         const token =req.header("x-auth-token"); // server extract the token using req.header the server verify the token using the jwt library if the tokn is valid then the server allow the request and to proced (e.g the next()) if invalid the response error (401.Unautorise)
//         if(!token) return res.json(false);// condition when user entr at very firsttime
//         const verified=jwt.verify(token,"passwordKey"); // verification of the token by using jwt lib
//         if(!verified) return res.json(false);
//       // after verification now check user is available or not so now verifiy the user is valid or not
//         const user=await User.findById(verified.id); // we are getting id because we are signin by id  after verfied we are gtting access to the id property that we store in it
//         if(!user)return res.json(false); // means if the user not exist return false
//         res.json(true);

        
//     } catch (e) {
//         res.status(500).json({error:e.message});
//     }
// });

// //get user data
// authRouter.get('/',auth,async (req,res)=> {    // here auth is the middleware which make sure that you are authorized  ...acces to this route if you are signind 
//     const user=await User.findById(req.user); // req.user is the id from the auth middleware
//     res.json({...user._doc,token:req.token});// req.token is the token from auth middleware
// });


// module.exports = authRouter;




const express = require("express");
const authRouter = express.Router();
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const auth = require("../middlewares/auth");

// SIGNUP API - Role-Based User Registration
authRouter.post("/api/signup", async (req, res) => {
    try {
        const { name, email, password, role } = req.body;

        if (!name || !email || !password || !role) {
            return res.status(400).json({ msg: "All fields are required" });
        }

        if (!["Doctor", "Patient", "Hospital"].includes(role)) {
            return res.status(400).json({ msg: "Invalid role. Choose 'Doctor', 'Patient', or 'Hospital'." });
        }

        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ msg: "User with this email already exists" });
        }

        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new User({
            name,
            email,
            password: hashedPassword,
            role
        });

        user = await user.save();

        res.json({ _id: user._id, name: user.name, email: user.email, role: user.role });

    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// SIGNIN API
authRouter.post("/api/signin", async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: "User with this email does not exist!" });
        }

        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect password." });
        }

        const token = jwt.sign({ id: user._id }, "passwordKey");

        res.json({
            token,
            _id: user._id,
            name: user.name,
            email: user.email,
            role: user.role
        });

    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// TOKEN VALIDATION
authRouter.post("/tokenIsValid", async (req, res) => {
    try {
        const token = req.header("x-auth-token");
        if (!token) return res.json(false);

        const verified = jwt.verify(token, "passwordKey");
        if (!verified) return res.json(false);

        const user = await User.findById(verified.id);
        if (!user) return res.json(false);

        res.json(true);

    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

// GET USER DATA
authRouter.get('/', auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;

//Set-ExecutionPolicy Bypass -Scope Process -Force
//AIzaSyBdIDv1XJ0mfes3rA0vWprw-FcZdfTFlxg




