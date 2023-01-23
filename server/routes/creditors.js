const router = require('express').Router();
const {verifyToken, verifyAdmin} = require('../middleware/verify-token');
const creditorController = require('../controllers/creditor_controller');

// Create A New Creditor
router.post('/', verifyAdmin, creditorController.create);

// Update Creditor
router.put('/:id', verifyAdmin, creditorController.update);
// Remove Creditor
router.delete('/:id', verifyAdmin, creditorController.remove);

// Get All Creditors Or Sorage
router.get('/', verifyToken, creditorController.getAll);

// Get One
router.get('/:id', verifyToken, creditorController.show);

module.exports = router;