const express = require("express");
const Hospital = require("../models/hospital_profile");
const upload = require("../middlewares/upload"); 

const router = express.Router();

// Add hospital
router.post("/hospitals", upload.single("image"), async (req, res) => {
  console.log("✅ /api/hospitals hit");

  try {
    const { name, location } = req.body;
    const image = req.file;

    if (!name || !location || !image) {
      return res.status(400).json({ error: "All fields are required" });
    }

    const imageUrl = `${req.protocol}://${req.get("host")}/uploads/${image.filename}`;

    const hospital = new Hospital({ name, location, imageUrl });
    await hospital.save();

    console.log("✅ Hospital saved:", hospital);
    res.status(201).json({ message: "Hospital added successfully", hospital });
  } catch (error) {
    console.error("🔥 Upload Error:", error);
    res.status(500).json({ error: "Server Error" });
  }
});

// Get all hospitals
router.get("/hospitals", async (req, res) => {
  try {
    const hospitals = await Hospital.find();
    res.status(200).json(hospitals);
  } catch (error) {
    res.status(500).json({ error: "Server Error" });
  }
});

module.exports = router;

