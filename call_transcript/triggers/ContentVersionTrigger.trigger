trigger ContentVersionTrigger on ContentVersion (after insert) {
    for (ContentVersion newVersion : Trigger.new) {
        try {
            // Call the flow 'AgentOrchestration' and pass the associated ContentDocumentId.
            if (newVersion.ContentDocumentId != null) {
                Flow.Interview.AgentOrchestration flow = new Flow.Interview.AgentOrchestration(
                    new Map<String, Object>{'ContentDocumentId' => newVersion.ContentDocumentId}
                );
                flow.start();
            }
        } catch (Exception e) {
            System.debug('Error processing PDF ContentVersion: ' + e.getMessage());
        }
    }
}