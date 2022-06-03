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

router.get('/:matricule/', function(req, res) {
	const { matricule } = req.params;

	if(matricule) {
		let sql = `
			SELECT *
			FROM reservations
			WHERE matricule = '${matricule}'
			ORDER BY created DESC
			LIMIT 1
		`;

		connection.query(sql, function(err, results) {
			if(err) return res.status(400).send(err);

			const result = results[0];
			if(!result) {
				return res.status(404).send('not found');
			}

			return res.send(result);
		});
	} else {
		return res.status(400).send('matricule is required');
	}
});

router.post('/', function(req, res) {
	const { userId, matricule, noHours, placeId } = req.body;

	let sql = `
		INSERT INTO reservations (userId, matricule, noHours, placeId)
		VALUES (?, ?, ?, ?)
	`;

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