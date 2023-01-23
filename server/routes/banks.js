const router = require('express').Router();
const {verifyToken, verifyAdmin} = require('../middleware/verify-token');
const bankController = require('../controllers/bank_controller');

// Create A New Bank
router.post('/', verifyAdmin, bankController.create);

// Update Bank
router.put('/:id', verifyAdmin, bankController.update);
// Remove Bank
router.delete('/:id', verifyAdmin, bankController.remove);

// Get All Banks Or Sorage
router.get('/', verifyToken, bankController.getAll);

// Get One
router.get('/:id', verifyToken, bankController.show);

module.exports = router;