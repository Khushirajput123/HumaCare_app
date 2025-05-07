


// // search_hospitals.js or similar route file
// const express = require("express");
// const axios = require("axios");
// const router = express.Router();
// const Hospital = require("../models/hospital_profile");

// router.get("/search_hospitals", async (req, res) => {
//   const query = req.query.q;
//   if (!query) return res.status(400).json({ error: "Query parameter is required" });

//   try {
//     const dbHospitals = await Hospital.find({
//       $or: [
//         { name: { $regex: query, $options: "i" } },
//         { location: { $regex: query, $options: "i" } }
//       ]
//     });

//     if (dbHospitals.length > 0) {
//       const hospitalsWithSource = dbHospitals.map(h => ({
//         ...h.toObject(),
//         source: "database"
//       }));
//       return res.json({ source: "db", hospitals: hospitalsWithSource });
//     }

//     const url = `https://nominatim.openstreetmap.org/search?format=json&q=${query} hospital&addressdetails=1&extratags=1`;
//     const response = await axios.get(url);

//     const hospitalsFromOSM = response.data.map(h => ({
//       name: h.display_name || "Unknown",
//       lat: h.lat,
//       lon: h.lon,
//       image: h.extratags?.image || "https://via.placeholder.com/150",
//       source: "osm"
//     }));

//     res.json({ source: "osm", hospitals: hospitalsFromOSM });

//   } catch (error) {
//     console.error("Search error:", error);
//     res.status(500).json({ error: "Error fetching hospital data" });
//   }
// });

// module.exports = router;


// search_hospitals.js

const express = require("express");
const axios = require("axios");
const router = express.Router();
const Hospital = require("../models/hospital_profile");

router.get("/search_hospitals", async (req, res) => {
  const query = req.query.q;
  if (!query) return res.status(400).json({ error: "Query parameter is required" });

  try {
    // Search from MongoDB
    const dbHospitals = await Hospital.find({
      $or: [
        { name: { $regex: query, $options: "i" } },
        { location: { $regex: query, $options: "i" } },
      ],
    });

    if (dbHospitals.length > 0) {
      const hospitalsWithSource = dbHospitals.map((h) => ({
        ...h.toObject(),
        source: "database",
      }));
      return res.json({ source: "db", hospitals: hospitalsWithSource });
    }

    // Fallback to OSM
    const url = `https://nominatim.openstreetmap.org/search?format=json&q=${query} hospital&addressdetails=1&extratags=1`;
    const response = await axios.get(url);

    const hospitalsFromOSM = response.data.map((h) => ({
      name: h.display_name || "Unknown",
      lat: h.lat,
      lon: h.lon,
      image: h.extratags?.image || "https://via.placeholder.com/150",
      source: "osm",
      address: h.address || {}, // Ensure address is always returned
      phone: h.extratags?.phone || "Unknown", // Ensure phone is available
      website: h.extratags?.website || "Not available", // Website info
    }));

    res.json({ source: "osm", hospitals: hospitalsFromOSM });
  } catch (error) {
    console.error("Search error:", error);
    res.status(500).json({ error: "Error fetching hospital data" });
  }
});

module.exports = router;
