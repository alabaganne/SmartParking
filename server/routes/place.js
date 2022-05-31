const connection = require('../connection');

const router = require('express').Router();

router.get('/', function(req, res) {
	const sql = 'SELECT * FROM places';

	connection.query(sql, function(err, rows) {
		if(err) return res.status(400).send(err);

		return res.send(rows);
	});
});

module.exports = router;