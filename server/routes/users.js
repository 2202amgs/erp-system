const router = require('express').Router();
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('../models/User');
const {verifyToken} = require('../middleware/verify-token');


// Sign In Router
router.post('/signin', async (req, res) => {
    try {
        const {email, password} = req.body;
        
        // Get user from databse
        const user = await User.findOne({email});
        
        // Chek email
        if (!user) return res.status(400).json({message: "هذا البريد غير مسجل..."});
        
        // Check password
        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) return res.status(400).json({message: "خطأ فى كلمة المرور..."});
        delete user._doc.password;
        // Generate token
        const token = jwt.sign({id: user._id, isAdmin: user.isAdmin}, process.env.KEY);
        
        // Response
        res.status(200).json({message: 'تم تسجيل الدخول بنجاح...', user: {token, ...user._doc}});
    } catch (error) {
        res.status(500).json({message: error.message});
    }
});

// Get User Data
router.post('/', verifyToken, async (req, res) => {
    // Check uid an token exists
    if (!req.user.id || !req.token) return res.status(401).json({message: "...لايوجد صلاحية وصول"});
    try {
        // Get user from db
        const user = await User.findById(req.user.id);
        if (!user) return req.status(400).json({message: "...هذا الحساب غير مسجل"});
        // Send user data
        delete user._doc.password
        res.status(200).json({...user._doc, token: req.token});
    } catch (error) {
        res.status(500).json({message: error.message});
    }
});

module.exports = router;
