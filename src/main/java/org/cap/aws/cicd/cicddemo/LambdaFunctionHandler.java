package org.cap.aws.cicd.cicddemo;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;

import org.json.simple.JSONObject;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.amazonaws.services.lambda.runtime.RequestStreamHandler;

public class LambdaFunctionHandler implements RequestStreamHandler {

	@SuppressWarnings("unchecked")
    public void handleRequest(InputStream input, OutputStream output, Context context) throws IOException {

        LambdaLogger logger = context.getLogger();
        logger.log("inside CICDDemp LAmbda...");


        JSONObject responseJson = new JSONObject();
        String jsonMessage = "{\n";
        jsonMessage += "    \"message\": \"Hello from CICD Demo Lambda\",\n";
        jsonMessage += "    \"lambdaFunctionName\": \"" + context.getFunctionName() + "\",\n";
        jsonMessage += "    \"lambdaFunctionVersion\": \"" + context.getFunctionVersion() + "\",\n";
        jsonMessage += "    \"lambdaFunctionInvokeARN\": \"" + context.getInvokedFunctionArn() + "\"\n";
        jsonMessage += "}";

        
        
        responseJson.put("isBase64Encoded", false);
        responseJson.put("statusCode", "200");
        responseJson.put("headers", null);
        responseJson.put("body", jsonMessage);
        
        logger.log(responseJson.toString());
        OutputStreamWriter writer = new OutputStreamWriter(output, "UTF-8");
        writer.write(responseJson.toString());
        writer.close();
    }

}
