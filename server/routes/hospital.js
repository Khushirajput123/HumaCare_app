

// // routes/details.js
// const express = require("express");
// const axios = require("axios");
// const router = express.Router();
// const Hospital = require("../models/manage_hospitaldetail");

// // Unified route to fetch hospital from DB or fallback to OSM by name only
// router.get("/detailss", async (req, res) => {
//   try {
//     const { name } = req.query;  // Only use the name parameter

//     // Check if the name parameter is provided
//     if (!name) {
//       return res.status(400).json({ error: "Missing hospital name" });
//     }

//     // First, try to find the hospital in the database
//     const hospital = await Hospital.findOne({ name });
//     if (hospital) {
//       return res.json({
//         source: "database",
//         details: hospital,
//       });
//     }

//     // If not found in database, fallback to OSM
//     const osmResponse = await axios.get("https://nominatim.openstreetmap.org/search", {
//       params: {
//         q: name,
//         format: "json",
//         addressdetails: 1,
//         extratags: 1,
//       },
//     });

//     if (!osmResponse.data || osmResponse.data.length === 0) {
//       return res.status(404).json({ error: "Hospital not found in both database and OSM" });
//     }

//     const hospitalData = osmResponse.data[0];

//     // Constructing details from OSM data
//     const details = {
//       name: hospitalData.display_name || "Unknown",
//       address: hospitalData.address || {},
//       phone: hospitalData.extratags?.phone || "xxxxxxxxxx",
//       website: hospitalData.extratags?.website || "Not available",
//       image: hospitalData.extratags?.image
//         ? hospitalData.extratags.image
//         : hospitalData.extratags?.wikimedia_commons
//         ? `https://upload.wikimedia.org/wikipedia/commons/${hospitalData.extratags.wikimedia_commons}`
//         : "https://via.placeholder.com/150",
//       lat: hospitalData.lat,
//       lon: hospitalData.lon,
//     };

//     // You can also send some placeholder doctors or fetch them from an external source
//     const doctors = [
//       { name: "Dr. John Doe", specialization: "Cardiologist" },
//       { name: "Dr. Jane Smith", specialization: "Orthopedic" },
//     ];

//     return res.json({
//       source: "osm",
//       details,
//       doctors,
//     });
//   } catch (err) {
//     console.error("Detail fetch error:", err.message);
//     res.status(500).json({ error: "Internal server error" });
//   }
// });
// module.exports = router;

const express = require("express");
const axios = require("axios");
const router = express.Router();
const ManageHospitalDetail = require("../models/manage_hospitaldetail");

router.get("/detailss", async (req, res) => {
  const name = req.query.name;
  if (!name) {
    return res.status(400).json({ error: "Name parameter is required" });
  }

  try {
    // 1️⃣ Try to get from MongoDB
    const hospital = await ManageHospitalDetail.findOne({ name });

    if (hospital) {
      return res.json({
        source: "database",
        details: hospital,
        doctors: hospital.doctors || [],
      });
    }

    // 2️⃣ Fallback: try to get from OSM
    const osmResponse = await axios.get("https://nominatim.openstreetmap.org/search", {
      params: {
        q: name + " hospital",
        format: "json",
        addressdetails: 1,
        extratags: 1,
      },
    });

    if (!osmResponse.data || osmResponse.data.length === 0) {
      return res.status(404).json({ error: "Hospital not found in both database and OSM" });
    }

    const hospitalData = osmResponse.data[0];

    // 3️⃣ Build detail object from OSM data
    const details = {
      name: hospitalData.display_name || "Unknown",
      address: hospitalData.address || {},
      phone: hospitalData.extratags?.phone || "xxxxxxxxxx",
      website: hospitalData.extratags?.website || "Not available",
      image: hospitalData.extratags?.image
        ? hospitalData.extratags.image
        : hospitalData.extratags?.wikimedia_commons
        ? `https://upload.wikimedia.org/wikipedia/commons/${hospitalData.extratags.wikimedia_commons}`
        : "https://via.placeholder.com/150",
      lat: hospitalData.lat,
      lon: hospitalData.lon,
    };

    const doctors = [
      { name: "Dr. John Doe", specialization: "Cardiologist" },
      { name: "Dr. Jane Smith", specialization: "Orthopedic" },
    ];

    return res.json({
      source: "osm",
      details,
      doctors,
    });
  } catch (error) {
    console.error("Error in /api/detailss:", error.message);
    return res.status(500).json({ error: "Internal Server Error" });
  }
});

module.exports = router;
