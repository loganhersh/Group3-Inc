const authService = require('../services/auth.service');

module.exports = {
  authenticate,
  logout
};

async function authenticate(req, res, next) {
  const {username,password} = req.body;
  authService.authenticate(username, password)
  .then(user => {
    if(user) {
      const {username, token} = user;
      const cookieConfig = {httpOnly: true, sameSite: true}
      res.cookie('auth', token, cookieConfig);
      res.json(username);
      next();
    } else {
      res.status(400).json({message: 'Username or password is incorrect'});
    }
  })
  .catch(err => next(err));
}

async function logout(req, res, next) {
  res.cookie('auth', null, {httpOnly: true, sameSite: true});
  res.send();
}
