const authService = require('../services/auth.service');

module.exports = {
  authenticate,
  logout
};

// Validates username & password against the database and then issues the user
// a cookie that contains a json web token
async function authenticate(req, res, next) {
  const {username,password} = req.body;
  authService.authenticate(username, password)
  .then(user => {
    if(user) {
      const {username, role, token} = user;
      const cookieConfig = {httpOnly: true, sameSite: true}
      res.cookie('auth', token, cookieConfig);
      res.json({ 'username': username, 'ad-auth': (role === 'admin') });
      next();
    } else {
      res.status(400).json({message: 'Username or password is incorrect'});
    }
  })
  .catch(err => next(err));
}

// Sets the users auth cookie to 'bad', removing their jwt
async function logout(req, res, next) {
  res.cookie('auth', 'bad', {httpOnly: true, sameSite: true});
  res.send();
}
