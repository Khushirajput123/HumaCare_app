const mongoose = require("mongoose");

const doctorSchema = new mongoose.Schema({
  name: { type: String, required: true },
  specialization: { type: String, required: true },
  available: { type: Boolean, default: true },
});

const hospitalSchema = new mongoose.Schema({
  name: { type: String, required: true, unique: true },
  location: { type: String, required: true },
  phone: { type: String, required: true },
  image: { type: String, required: true },
  description: { type: String },
  doctors: [doctorSchema],
});

const Hospital = mongoose.model("ManageHospital", hospitalSchema);
module.exports = Hospital;
