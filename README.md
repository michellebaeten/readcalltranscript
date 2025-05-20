This can be used to implement an Agentforce use case where we want Agentforce to process call transcripts coming from an external system (like MS Teams), then process this and create/update records based off what was discussed in the call. For these type of scenarios it is always preferable to lead with Einstein Conversation Insights as it's native functionality and more feature rich. If for whatever reason the customer can't use ECI this could be used as an alternativve way to demonstrate call transcript processing. 

The processing works as follows: 

Assuming the call transcript is sent to Salesforce over API and stored as a File, Apex Trigger on ContentVersionTrigger calls the flow AgentOrchestration
the flow retrieves the document then calls the Prompt Action Process Call Transcript
Prompt Action will go through the transcript and generate the values for the Call in json format
json is sent back to the flow and sent to an invocable apex method (ProcessJsonData) to parse the json to variables
the variables are sent to a subflow which creates the call record (Create Call and Prompt)
the main flow then finds all relevant Prompt records
details of all the prompt records are put into the next prompt action (Analyse Call Transcript against Prompts)
the prompt action goes through the call transcript again and checks whether the prompt record was discussed. It generates a json with a true/false value for each prompt record
the flow parses the json with formula field and updates the prompt record for each true value
