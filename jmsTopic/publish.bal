import ballerina/jms;
import ballerina/log;
endpoint jms:SimpleTopicPublisher topicPublisher {
     initialContextFactory:"com.sun.jndi.fscontext.RefFSContextFactory",
    providerUrl:"file:///home/riyafa/Documents/Workspace/jms/jmsTopic",
    acknowledgementMode:"AUTO_ACKNOWLEDGE",
    topicPattern:"BallerinaTopic"
};function main(string... args) {
    match (topicPublisher.createTextMessage("Hello from Ballerina")) {
        error e => {
            log:printError("Error occurred while creating message", err=e);
        }        jms:Message msg => {
            topicPublisher->send(msg) but {
                error e => log:printError("Error occurred while sending"
                                           + "message", err=e)
            };
        }
    }
}
