var user = JSON.parse(localStorage.getItem('user'));
if(!user) {
	window.location.replace('http://localhost:8000/index.html');
} else if(window.location.href.includes('index.html') || window.location.href.includes('register.html')) {
	window.location.replace('http://localhost:8000/reservations.html');
}
console.log('user', user);

let logoutBtn = document.getElementById('logoutBtn');
logoutBtn.addEventListener('click', function(e) {
	console.log('logout');
	localStorage.removeItem('user');
	user = null;
	window.location.replace('http://127.0.0.1:8000/index.html')
});