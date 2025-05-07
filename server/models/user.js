
const mongoose = require('mongoose'); // Import mongoose

// Define the User Schema
const userSchema = mongoose.Schema({
    name: {
        required: true, // User must enter a name
        type: String,
        trim: true, // Removes extra spaces
    },
    email: {
        required: true,
        type: String,
        trim: true,
        unique: true, // Ensures email is unique
        validate: {
            validator: (value) => {
                const re =
                    /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            message: "Please enter a valid email address",
        },
    },
    password: {
        required: true,
        type: String,
    },
    address: {
        type: String,
        default: "", // Empty by default
    },
    type: {
        type: String,
        default: "user",
    },
    role: {
        type: String,
        enum: ["Doctor", "Patient", "Hospital"], // ✅ Added Hospital role
        required: true,
    },
});

// Create the User model
const User = mongoose.model("User", userSchema);
module.exports = User;
