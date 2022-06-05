const connection = require('../connection');

const router = require('express').Router();

router.get('/', function(req, res) {
	// get empty places (parking spots)
	const sql = `
		SELECT *
		FROM places p
		WHERE NOT EXISTS (
			SELECT *
			FROM reservations r
			WHERE p.id = r.placeId
			AND ADDDATE(r.created, INTERVAL r.noHours HOUR ) < CURRENT_TIMESTAMP
		)
	`;

	connection.query(sql, function(err, rows) {
		if(err) return res.status(400).send(err);

		return res.send(rows);
	});
});

module.exports = router;