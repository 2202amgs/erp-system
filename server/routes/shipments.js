const router = require('express').Router();
const {verifyToken, verifyAdmin} = require('../middleware/verify-token');
const shipmentController = require('../controllers/shipments_controller');

// Create A New Shipment
router.post('/', verifyAdmin, shipmentController.create);

// Update Shipment
router.put('/:id', verifyAdmin, shipmentController.update);

// Remove Shipment
router.delete('/:id', verifyAdmin, shipmentController.remove);

// Get All Shipments
router.get('/', verifyToken, shipmentController.getByDate);

module.exports = router;