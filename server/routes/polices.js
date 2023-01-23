const router = require('express').Router();
const {verifyToken, verifyAdmin} = require('../middleware/verify-token');
const policesController = require('../controllers/polices_controller');

// Create A New Plicy
router.post('/', verifyAdmin, policesController.create);

// Update Plicy
router.put('/:id', verifyAdmin, policesController.update);

// Remove Plicy
router.delete('/:id', verifyAdmin, policesController.remove);

// Get All Plices
router.get('/', verifyToken, policesController.getByDate);

module.exports = router;