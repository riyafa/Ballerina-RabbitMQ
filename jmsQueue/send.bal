import ballerina/jms;
import ballerina/log;
endpoint jms:SimpleQueueSender queueSender {
    initialContextFactory:"com.sun.jndi.fscontext.RefFSContextFactory",
    providerUrl:"file:///home/riyafa/Documents/Workspace/jms/jmsQueue",
    acknowledgementMode:"AUTO_ACKNOWLEDGE",
    queueName:"MyQueue"
};function main(string... args) {
    match (queueSender.createTextMessage("Hello from Ballerina")) {
        error e => {
            log:printError("Error occurred while creating message", err = e);
        }        jms:Message msg => {
            queueSender->send(msg) but {
                error e => log:printError("Error occurred while sending"
                                          + "message", err = e)
            };
        }
    }
}
