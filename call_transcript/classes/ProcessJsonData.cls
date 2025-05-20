// Class definition
public class ProcessJsonData {

    // Inner class to define the structure of the input JSON data.
    public class InputData {
        @AuraEnabled public String Subject { get; set; }
        @AuraEnabled public String Sales_or_Service { get; set; }
        @AuraEnabled public String Was_the_Call_Pro_or_Reactive { get; set; }
        @AuraEnabled public String Call_Duration { get; set; }
        @AuraEnabled public String Were_there_any_Complaints { get; set; }
        @AuraEnabled public String Was_this_a_Microsoft_Teams_Call { get; set; }
        @AuraEnabled public String Status { get; set; }
        @AuraEnabled public String Primary_Product { get; set; }
        @AuraEnabled public String Primary_Activity { get; set; }
        @AuraEnabled public String Secondary_Activity { get; set; }
        @AuraEnabled public String Comments_or_Summary_of_call { get; set; }
        @AuraEnabled public String Contact { get; set; }
    }

    // Inner class to define the structure of the output JSON data.
    public class OutputData {
        @InvocableVariable public String CallDuration;
        @InvocableVariable public String Comments;
        @InvocableVariable public String Complaints;
        @InvocableVariable public String ContactName;
        @InvocableVariable public String MSTeamsCall;
        @InvocableVariable public String PrimaryActivity;
        @InvocableVariable public String PrimaryProduct;
        @InvocableVariable public String ProorReactive;
        @InvocableVariable public String SalesorService;
        @InvocableVariable public String SecondaryActivity;
        @InvocableVariable public String Status;
        @InvocableVariable public String Subject;
    }

    // Invocable method definition.
    @InvocableMethod(label='Process JSON Data' description='Processes a JSON string and returns values.')
    public static List<OutputData> processJson(List<String> jsonStrings) {
        List<OutputData> results = new List<OutputData>();

        for (String jsonString1 : jsonStrings) {
            try {
                String jsonString2 = jsonString1.substring(jsonString1.indexOf('{'));
                String jsonString = jsonString2.substring(0, jsonString2.lastIndexOf('}') + 1);
                InputData data = (InputData)JSON.deserialize(jsonString, InputData.class);
                OutputData result = new OutputData();

                // Map the input fields to the output fields.
                result.Subject = data.Subject;
                result.SalesorService = data.Sales_or_Service;
                result.ProorReactive = data.Was_the_Call_Pro_or_Reactive;
                result.CallDuration = data.Call_Duration;
                result.Complaints = data.Were_there_any_Complaints;
                result.MSTeamsCall = data.Was_this_a_Microsoft_Teams_Call;
                result.Status = data.Status;
                result.PrimaryProduct = data.Primary_Product;
                result.PrimaryActivity = data.Primary_Activity;
                result.SecondaryActivity = data.Secondary_Activity;
                result.Comments = data.Comments_or_Summary_of_call;
                result.ContactName = data.Contact;

                results.add(result);
            } catch (Exception e) {
                OutputData errorResult = new OutputData();
                errorResult.Subject = 'Error: ' + e.getMessage(); // Include error in one of the output fields.
                results.add(errorResult);
                System.debug('JSON Processing Error: ' + e.getMessage() + ' for JSON String: ' + jsonString1);
            }
        }
        return results;
    }
}