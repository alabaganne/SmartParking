const app = require('express')();
const port = 3000;
const bodyParser = require('body-parser');
const cors = require('cors');

app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use('/api/login', require('./routes/login.js'));
app.use('/api/register', require('./routes/register'));
app.use('/api/reservations', require('./routes/reservation'));

app.listen(3000, () => {
	console.log('app is listening on port ' + port);
});