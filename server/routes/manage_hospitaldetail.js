// const express = require("express");
// const router = express.Router();
// const Hospital = require("../models/manage_hospitaldetail");

// // POST: Create or update hospital availability
// router.post("/manage-hospital", async (req, res) => {
//   try {
//     const { name, location, phone, image, description, doctors } = req.body;

//     let hospital = await Hospital.findOne({ name });

//     if (hospital) {
//       // Update
//       hospital.location = location;
//       hospital.phone = phone;
//       hospital.image = image;
//       hospital.description = description;
//       hospital.doctors = doctors;
//       await hospital.save();
//       return res.status(200).json({ message: "Hospital updated", hospital });
//     } else {
//       // Create
//       const newHospital = new Hospital({
//         name,
//         location,
//         phone,
//         image,
//         description,
//         doctors,
//       });
//       await newHospital.save();
//       return res.status(201).json({ message: "Hospital created", hospital: newHospital });
//     }
//   } catch (err) {
//     console.error("Error saving hospital:", err);
//     res.status(500).json({ message: "Server error", error: err.message });
//   }
// });

// // GET: Fetch hospital availability by name
// router.get("/manage-hospital/:name", async (req, res) => {
//   try {
//     const name = req.params.name;
//     const hospital = await Hospital.findOne({ name });
//     if (!hospital) {
//       return res.status(404).json({ message: "Hospital not found" });
//     }
//     res.status(200).json(hospital);
//   } catch (err) {
//     console.error("Fetch error:", err);
//     res.status(500).json({ message: "Server error", error: err.message });
//   }
// });

// module.exports = router;



const express = require("express");
const router = express.Router();
const Hospital = require("../models/manage_hospitaldetail");

// POST: Create or update hospital availability
router.post("/manage-hospital", async (req, res) => {
  try {
    const { name, location, phone, image, description, doctors } = req.body;

    let hospital = await Hospital.findOne({ name });

    if (hospital) {
      // Update
      hospital.location = location;
      hospital.phone = phone;
      hospital.image = image;
      hospital.description = description;
      hospital.doctors = doctors;
      await hospital.save();
      return res.status(200).json({ message: "Hospital updated", hospital });
    } else {
      // Create
      const newHospital = new Hospital({
        name,
        location,
        phone,
        image,
        description,
        doctors,
      });
      await newHospital.save();
      return res.status(201).json({ message: "Hospital created", hospital: newHospital });
    }
  } catch (err) {
    console.error("Error saving hospital:", err);
    res.status(500).json({ message: "Server error", error: err.message });
  }
});

// GET: Fetch hospital availability by name
router.get("/manage-hospital/:name", async (req, res) => {
  try {
    const name = req.params.name;
    const hospital = await Hospital.findOne({ name });
    if (!hospital) {
      return res.status(404).json({ message: "Hospital not found" });
    }
    res.status(200).json(hospital);
  } catch (err) {
    console.error("Fetch error:", err);
    res.status(500).json({ message: "Server error", error: err.message });
  }
});

module.exports = router;