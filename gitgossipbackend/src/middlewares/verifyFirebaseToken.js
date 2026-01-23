
import admin from "../services/firebaseAdmin.js";

const verifyFirebaseToken = async (req, res, next) => {
    try {
        console.log("🛡️ AUTH MIDDLEWARE HIT");
        // This line of code only reads the token
        const authHeader = req.headers.authorization;

        console.log("AUTH HEADER:", req.headers.authorization);

        // Chechking if the header exists and follows Bearer schema 
        if (!authHeader || !authHeader.startsWith("Bearer ")) {
            return res.status(401).json({ message: "Authorization header missing" });
        }

        // extracting only the token removing bearer
        const token = authHeader.split(" ")[1];


        // verifying token with firehbase admin 
        const decodedToken = await admin.auth().verifyIdToken(token, true); // check revocation

        // Normalize auth context
        req.user = {
            uid: decodedToken.uid,
            email: decodedToken.email || null,
            name: decodedToken.name || null,
            picture: decodedToken.picture || null,
            provider: decodedToken.firebase?.sign_in_provider || null,
        };


        // continue to next middleware 
        next();
    } catch (error) {
        console.error("Auth error:", error.code || error.message);
        console.log("AUTH USER:", req.user);

        return res.status(401).json({ message: "Unauthorized" });
    }
};

export default verifyFirebaseToken;



