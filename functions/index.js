const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.sendNotificationOnNotesChange = functions.firestore.document('notes/{text}').onUpdate(async (snap, context) => {
    const oldData = snap.before.data();
    const newData = snap.after.data();
    const tokenSnapshot = await admin.firestore().collection('tokens').doc('tokens').get();

    const tokens = tokenDoc.data().tokenList; 
    
    console.log(tokens.toString());
    if (oldData.text !== newData.text) {
        const payLoad = {
            notification: {
                title: 'Notes changed now',
                body: oldData.text + 'replaced to' + newData.text,
            },
            tokens : tokens, 
        }
        try {
            const response = await admin.messaging().sendEachForMulticast(payLoad);
        } catch (error) {
            console.log(error);
        }
    }
})