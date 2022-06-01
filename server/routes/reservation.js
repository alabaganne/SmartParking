const connection = require('../connection');

const router = require('express').Router();

router.get('/', function(req, res) {
	const { userId } = req.query;

	let sql;
	if(userId) {
		sql = `
			SELECT *
			FROM reservations
			WHERE userId = ${userId}
		`
	} else {
		sql = `
			SELECT r.*, u.name
			FROM reservations r
			LEFT JOIN users AS u ON u.id = r.userId
		`;
	}

	connection.query(sql, function(err, result) {
		if(err) res.status(400).send(err);

		res.send(result);
	});
});

router.post('/', function(req, res) {
	const { userId, matricule, noHours, placeId } = req.body;

	let sql = `
		INSERT INTO reservations (userId, matricule, noHours, placeId)
		VALUES (?, ?, ?, ?)
	`;

	console.log('add reservation has been hit');
	connection.query(sql, [userId, matricule, noHours, placeId], function(err, result) {
		if(err) return res.status(400).send(err);

		res.status(201).send('created');
	});
});

router.delete('/:id/', function(req, res) {
	const { id } = req.params;

	const sql = `
		DELETE FROM reservations
		WHERE id = ?
	`;

	connection.query(sql, id, function(err, result) {
		if(err) return res.status(400).send(err);

		res.send('deleted');
	});
});

module.exports = router;