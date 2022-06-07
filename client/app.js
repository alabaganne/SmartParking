const protectedRoutes = [
	'reservations',
	'add_reservation'
];

var user = null;
function init() {
	user = JSON.parse(window.localStorage.getItem('user'));
	let routeProtected = false;
	for(let i = 0; i < protectedRoutes.length; i++) {
		if(window.location.href.includes(protectedRoutes[i])) {
			routeProtected = true
			break;
		}
	}
	
	// if unauthenticated user tries to access protected route, redirect to welcome page where he can login
	if(!user && routeProtected) {
		window.location.replace('http://localhost:8000/index.html');
	} else if(user && !routeProtected) { // if authenticated user tries to access login page, redirect to reservations page
		window.location.replace('http://localhost:8000/reservations.html');
	}
}
init();

let logoutBtn = document.getElementById('logoutBtn');
if(logoutBtn) {
	logoutBtn.addEventListener('click', function(e) {
		window.localStorage.clear();
		user = null;
		window.location.href = '/index.html';
	});
}