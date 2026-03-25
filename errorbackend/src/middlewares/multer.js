import multer from "multer";

const storage = multer.memoryStorage();

const upload = multer({
    storage,
    limits: { fileSize: 5 * 1024 * 1024 }, // 5MB
});

export default upload;


// const multer = require('multer');

// const storage = multer.diskStorage({
//   filename: function (req,file,cb) {
//     cb(null, file.originalname)
//   }
// });

// const upload = multer({storage: storage});

// module.exports = upload;