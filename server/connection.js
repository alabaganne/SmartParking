const mysql = require('mysql');

let connection = mysql.createConnection({
	host: 'localhost',
	user: 'root',
	password: '',
	database: 'smart_parking'
});

connection.connect();
console.log('connected to mysql database');

module.exports = connection;