import admin from "../services/firebaseAdmin.js";

const verifyFirebaseToken = async (req, res, next) => {
    try {
        const token = req.headers.authorization?.split(" ")[1];

        if (!token) return res.status(401).json({ message: "No token provided" });

        const decoded = await admin.auth().verifyIdToken(token);

        req.user = decoded; // attach user to request
        next();
    } catch (error) {
        console.log(error);
        return res.status(401).json({ message: "Invalid token" });
    }
};

export default verifyFirebaseToken;
