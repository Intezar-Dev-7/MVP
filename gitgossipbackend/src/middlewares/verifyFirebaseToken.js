
import admin from "../services/firebaseAdmin.js";

const verifyFirebaseToken = async (req, res, next) => {
    try {
        const authHeader = req.headers.authorization;

        if (!authHeader || !authHeader.startsWith("Bearer ")) {
            return res.status(401).json({ message: "Authorization header missing" });
        }

        const token = authHeader.split(" ")[1];

        const decoded = await admin.auth().verifyIdToken(token, true); // check revocation

        // Normalize auth context
        req.auth = {
            uid: decoded.uid,
            email: decoded.email || null,
            name: decoded.name || null,
            picture: decoded.picture || null,
            provider: decoded.firebase?.sign_in_provider || null,
        };

        next();
    } catch (error) {
        console.error("Auth error:", error.code || error.message);
        return res.status(401).json({ message: "Unauthorized" });
    }
};

export default verifyFirebaseToken;



