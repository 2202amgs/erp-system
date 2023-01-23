const router = require('express').Router();
const {verifyToken, verifyAdmin} = require('../middleware/verify-token');
const debitController = require('../controllers/debit_controller');

// Create A New debit
router.post('/', verifyAdmin, debitController.create);

// Update debit
router.put('/:id', verifyAdmin, debitController.update);
// Remove debit
router.delete('/:id', verifyAdmin, debitController.remove);

// Get All debits
router.get('/', verifyToken, debitController.getAll);

// Get One
router.get('/:id', verifyToken, debitController.show);

module.exports = router;