/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
const functions = require("firebase-functions");
const nodemailer = require("nodemailer");

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "renata.porto.gransoti@gmail.com",
    pass: "ahpgpdyusnznyoif",
  },
});

exports.sendEmail = functions.https.onRequest((req, res) => {
  const {nomeCompleto, email, celular, mensagem} = req.body;
  const mailOptions={
    from: email,
    to: "renata.porto.gransoti@gmail.com",
    subject: "Novo e-mail do app PNSG",
    text: `Nome: ${nomeCompleto}\nEmail: ${email}\n
    Celular: ${celular}\nMensagem: ${mensagem}`,
  };

  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      return res.status(500).send(error.toString());
    }
    return res.status(200).send(`Email enviado: ${info.response}`);
  });
});

