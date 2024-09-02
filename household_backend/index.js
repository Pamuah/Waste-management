const express = require("express");
const bodyParser = require("body-parser");
const db = require("./db");
const cors = require("cors");
const usersRoute = require("./controllers/users.controller");


// App config
const app = express();


// Middleware config
app.use(bodyParser.json());
app.use(cors());
app.use('/household-api/users', usersRoute);

// Check database connection and start server
db.query("SELECT 1")
  .then(() => {
    console.log("DB connection successful");
    // Start server
    app.listen(3000, () => console.log("mhealth_app express server started at port 3000"));
  })
  .catch(e => console.log(e + " DB connection unsuccessful"));