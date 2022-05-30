const connection = require('../connection');

const router = require('express').Router();

router.get('/', function(req, res) {
	let sql = 'SELECT * FROM reservations';

	if(req.query.userId) {
		sql += ' WHERE userId = ' + req.query.userId;
	}

	connection.query(sql, function(err, result) {
		if(err) res.status(400).send(err);

		res.send(result);
	});
});

router.post('/', function(req, res) {
	const { fullName, matricule, noHours } = req.body;

	let sql = `
		INSERT INTO reservations (fullName, matricule, noHours)
		VALUES (?, ?, ?)
	`;

	connection.query(sql, [fullName, matricule, noHours], function(err, result) {
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