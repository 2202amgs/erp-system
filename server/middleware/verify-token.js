const jwt = require('jsonwebtoken');

const verifyToken =  (req, res, next) => {
    try{
        // Get token from header
        const token = req.header('token');
        if (!token) return res.status(401).json({message: "...لا يوجد لديك صلاحية الدخول"});
        // Token verify
        const verified = jwt.verify(token, process.env.KEY);
        if (!verified) return res.status(401).json({message: "...خطأ فى التحقق من حسابك"});
        // Set data and next step
        req.token = token
        req.user = verified;
        next();
    } catch(error){
        return res.status(500).json({message: error.message});
    }
};

const verifyAdmin = (req, res, next) => {
    verifyToken(req, res, async () => {
        try {
            if(!req.user.isAdmin) return res.status(401).json({message: "...لا يوجد لديك صلاحية الدخول"});
            next();
        } catch (error) {
            return res.status(500).json({message: error.message});
        }
    });
};


module.exports = {verifyToken, verifyAdmin};