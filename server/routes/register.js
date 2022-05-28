const connection = require('../connection');

const router = require('express').Router();

router.post('/', function(req, res) {
	const { cin, name, password } = req.body;

	const sql = `
		INSERT INTO users (cin, name, password)
		VALUES (?, ?, ?)
	`;

	connection.query(sql, [cin, name, password], function(err, result) {
		if(err) return res.status(400).send(err);

		res.status(201).send('created');
	})
});

module.exports = router;