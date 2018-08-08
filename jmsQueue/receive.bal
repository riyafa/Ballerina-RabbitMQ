import ballerina/jms;
import ballerina/log;
endpoint jms:SimpleQueueReceiver consumerEndpoint {
    initialContextFactory:"com.sun.jndi.fscontext.RefFSContextFactory",
    providerUrl:"file:///home/riyafa/Documents/Workspace/jms/jmsQueue",
    acknowledgementMode:"AUTO_ACKNOWLEDGE",
    queueName:"MyQueue"
};
service<jms:Consumer> jmsListener bind consumerEndpoint {
    onMessage(endpoint cons, jms:Message message) {
        match (message.getTextMessageContent()) {
            string messageText => log:printInfo("Message : " + messageText);
            error e => log:printError("Error occurred while reading message",
                                       err=e);
        }
    }
}
