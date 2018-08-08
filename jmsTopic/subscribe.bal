import ballerina/jms;
import ballerina/log;
endpoint jms:SimpleTopicSubscriber subscriber {
     initialContextFactory:"com.sun.jndi.fscontext.RefFSContextFactory",
    providerUrl:"file:///home/riyafa/Documents/Workspace/jms/jmsTopic",
    acknowledgementMode:"AUTO_ACKNOWLEDGE",
    topicPattern:"BallerinaTopic"
};
service<jms:Consumer> jmsListener bind subscriber {
    onMessage(endpoint consumer, jms:Message message) {
        match (message.getTextMessageContent()) {
            string messageText => log:printInfo("Message : " + messageText);
            error e => log:printError("Error occurred while reading message",
                                      err=e);
        }
    }
}
