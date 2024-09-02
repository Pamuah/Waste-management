const express = require("express");

router = express.Router();

const service = require("../services/users.service");

var otp = 0;


// Add User
router.post('/register', async (req, res) => {
    try {
        const user = await service.getUserByEmail(req.body)
        console.log(user.length)
        if (user.length > 0) {
            throw "duplicate email address"
        }
        else {
            const result = await service.addUser(req.body)
            res.send(result)
        }
    } catch (error) {
        console.log(error);
        res.status(500).send(error);
    }
    
    // res.status(200).send("User successfully added")
    
}) 
 
// Login
router.get('/login/:email/:password', async (req, res) => {
    email = req.params.email;
    password = req.params.password;
    try {
       const response = await service.logIn(email, password)
        console.log(response['message'] == null);
        if (response['message'] == undefined) {
            console.log("Login successful")
            res.status(200).send(response);
        }
        else {
            res.status(400).send(response);
        }   
    } catch (error) {
        console.log(error)
        throw error;
    }
}) 

module.exports = router;