const db = require('../db')
const bcrypt = require("bcrypt");

// Register
module.exports.addUser = async(obj) => {
    const id = parseInt((Date.now() * Math.random()).toString().substring(0, 8));
    const password = obj.password;
    const email = obj.email.trim();
    const name = obj.name.trim();
    const saltRounds = Math.floor(Math.random() * 20);
    bcrypt.hash(password, saltRounds, async (err, hashedPassword) => {
        if(err){
            console.log(err.message);
            // throw "Error Hashing Password";
        }
        console.log(saltRounds);
        const response = await db.query('INSERT INTO users(id, name, email, password) VALUES (?, ?, ?, ?)', [id, name, email, hashedPassword])
            .catch(e => {
                console.log(e);
                // throw "database query error"
            });
        return response;
    })
}

// Get user by email
module.exports.getUserByEmail = async (obj) => {
    const email = obj.email;
    const [data] = await db.query("SELECT * FROM users WHERE email = ?",[email])
        .catch(error => {
            console.log(error)
            throw error;
        })
        return data;
}

// Login
module.exports.logIn = async (email, password) => {
    const response = await db.query("SELECT * FROM users WHERE email = ?", [email])
        .catch(e => { console.log(e); throw "database query error" });
    // console.log(response[0].length)
    if (response[0].length > 0) {
            const hashedPassword = response[0][0].password;
            if(bcrypt.compareSync(password, hashedPassword)){
                return response[0];
            }
            else
                return {"message":"login failed"};
        }else
        return {"message":"no account exists for this email"};
}