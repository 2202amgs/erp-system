const router = require('express').Router();
const {verifyToken, verifyAdmin} = require('../middleware/verify-token');
const carController = require('../controllers/car_controller');
// Create A New Car
router.post('/', verifyAdmin, carController.create);

// Update Car
router.put('/:id', verifyAdmin, carController.update);

// Remove Car
router.delete('/:id', verifyAdmin, carController.remove);

// Get All Cars
router.get('/', verifyToken, carController.getALl);

// Get One Car
router.get('/:id', verifyToken, carController.show);

module.exports = router;