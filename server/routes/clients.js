const router = require('express').Router();
const clientController = require('../controllers/client_controller');
const {verifyToken, verifyAdmin} = require('../middleware/verify-token');


// Create A New Client
router.post('/', verifyAdmin, clientController.create);

// Update Client
router.put('/:id', verifyAdmin, clientController.update);
// Remove Client
router.delete('/:id', verifyAdmin, clientController.remove);

// Get All Clients
router.get('/', verifyToken, clientController.getALl);

// Get One Clients
router.get('/:id', verifyToken, clientController.show);

module.exports = router;