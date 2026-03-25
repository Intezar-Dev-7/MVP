
import admin from "../services/firebaseAdmin.js";

const verifyFirebaseToken = async (req, res, next) => {
    try {
        console.log("🛡️ AUTH MIDDLEWARE HIT");
        // This line of code only reads the token
        const authHeader = req.headers.authorization;

        console.log("AUTH HEADER:", req.headers.authorization);

        // Checking if the header exists and follows Bearer schema 
        if (!authHeader || !authHeader.startsWith("Bearer ")) {
            return res.status(401).json({ message: "Authorization header missing" });
        }

        // extracting only the token removing bearer
        const token = authHeader.split(" ")[1];


        // Step 3: Verify token with Firebase
        console.log("🔐 Verifying token with Firebase Admin...");
        // verifying token with firebase admin 
        const decodedToken = await admin.auth().verifyIdToken(token, true); // check revocation

        // Normalize auth context
        req.user = {
            firebaseUid: decodedToken.uid,
            email: decodedToken.email || null,
            fullName: decodedToken.name || null,
            profilePic: decodedToken.picture || null,
            provider: decodedToken.firebase?.sign_in_provider || null,
        };

        console.log("Firebase Verification Completed");
        // continue to next middleware 
        next();
    } catch (error) {
        console.error("Auth error:", error.code || error.message);


        return res.status(401).json({ message: "Unauthorized" });
    }
};




export default verifyFirebaseToken;



