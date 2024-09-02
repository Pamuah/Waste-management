const mysql = require("mysql2/promise")

const mysqlpool = mysql.createPool({
    host:'localhost',
    user:'root',
    password:'Amuah2420',
    database:'household_db'
})

module.exports = mysqlpool
