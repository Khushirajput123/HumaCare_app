
// require("dotenv").config();
// const express = require("express");
// const mongoose = require("mongoose");
// const cors = require("cors");

// const authRouter = require("./routes/auth");
// const searchRoutes = require("./routes/search");
// const hospitalSearchRoutes = require("./routes/hospital"); // for search
// const hospitalProfileRoutes = require("./routes/hospital_profile"); // for uploading data
// const manageAvailableRoute = require("./routes/manage_hospitaldetail");
// const PORT = 3000;
// const app = express();
// const DB = "mongodb+srv://deepukumar13102003:d1YaCJt2WQjAaJSr@cluster0.wh36uzg.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// // Middleware
// app.use(cors());
// app.use(express.json());
// app.use(express.urlencoded({ extended: true }));
// app.use("/uploads", express.static("uploads"));

// // Routes
// app.use("/", authRouter);
// app.use("/api", searchRoutes);
// app.use("/api", hospitalSearchRoutes);       // GET hospitals
// app.use("/api", hospitalProfileRoutes);      // POST hospital with image
// app.use("/api",manageAvailableRoute );

// // Root route
// app.get("/", (req, res) => {
//   res.send("Server is running!");
// });

// // DB connection
// mongoose.connect(DB, {
//   useNewUrlParser: true,
//   useUnifiedTopology: true,
// }).then(() => console.log("Connection Successful"))
//   .catch((e) => console.error("Connection error:", e));

// app.listen(PORT, "0.0.0.0", () => {
//   console.log(`Connected at port ${PORT}`);
// });


require("dotenv").config();
const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const authRouter = require("./routes/auth");
const searchRoutes = require("./routes/search");
const hospitalSearchRoutes = require("./routes/hospital"); // for search
const hospitalProfileRoutes = require("./routes/hospital_profile"); // for uploading data
const manageAvailableRoute = require("./routes/manage_hospitaldetail"); // for managing availability


const app = express();
const PORT = 3000;

const DB = "mongodb+srv://deepukumar13102003:d1YaCJt2WQjAaJSr@cluster0.wh36uzg.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use("/uploads", express.static("uploads"));

// Routes
app.use("/", authRouter);
app.use("/api", searchRoutes);
app.use("/api", hospitalSearchRoutes);       // GET hospitals
app.use("/api", hospitalProfileRoutes);      // POST hospital with image
app.use("/api", manageAvailableRoute);       // Manage doctor availability
             // GET hospital detail (DB or fallback)

// Root route
app.get("/", (req, res) => {
  res.send("Server is running!");
});

// MongoDB connection
mongoose.connect(DB, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
}).then(() => console.log("MongoDB connected"))
  .catch((e) => console.error("MongoDB connection error:", e));

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${PORT}`);
});
