const mongoose = require("mongoose");

const hospitalSchema = new mongoose.Schema({
  name: { type: String, required: true },
  location: { type: String, required: true },
  imageUrl: { type: String, required: true }, // Store image URL
}, { timestamps: true });

const Hospital = mongoose.model("Hospital", hospitalSchema);
module.exports = Hospital;
