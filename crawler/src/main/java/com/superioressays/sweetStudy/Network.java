package com.superioressays.sweetStudy;

import com.squareup.okhttp.*;
import org.json.JSONObject;

import java.io.IOException;
import java.util.Base64;

/**
 * Created by otikev on 25-Jul-2022
 */

public class Network {

    static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");

    static final String AGENT_HEADER = "SE_AGENT_TOKEN";
    static final String AGENT_HEADER_VALUE = "randomvaluefortestthatisusedwhenthereisnotokensetintheenvironmentvariables";

    //static String baseUrl = "https://www.superioressays.pro/";
    static String baseUrl = "http://localhost:5000/";

    static OkHttpClient client = new OkHttpClient();

    private static String getAbsoluteUrl(String endpoint) {
        return baseUrl + endpoint;
    }

    public static boolean notifyBatchComplete(String hostname) throws IOException {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("host", hostname);
        String json = jsonObject.toString();

        RequestBody body = RequestBody.create(JSON, json);
        Request request = new Request.Builder()
                .addHeader(AGENT_HEADER, AGENT_HEADER_VALUE)
                .url(getAbsoluteUrl("agent/batch_complete"))
                .post(body)
                .build();

        Response response = client.newCall(request).execute();
        if (response.code() == 200) {
            return true;
        } else {
            return false;
        }
    }

    public static boolean notifyStart(String hostname) throws IOException {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("host", hostname);
        String json = jsonObject.toString();

        RequestBody body = RequestBody.create(JSON, json);
        Request request = new Request.Builder()
                .addHeader(AGENT_HEADER, AGENT_HEADER_VALUE)
                .url(getAbsoluteUrl("agent/start"))
                .post(body)
                .build();

        Response response = client.newCall(request).execute();
        if (response.code() == 200) {
            return true;
        } else {
            return false;
        }
    }

    public static boolean createQuestion(Question question) throws IOException {
        String encodedUrl = Base64.getEncoder().encodeToString(question.targetUrl.getBytes());
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("title", question.title);
        jsonObject.put("link", encodedUrl);
        jsonObject.put("question", question.description);
        String json = jsonObject.toString();

        RequestBody body = RequestBody.create(JSON, json);
        Request request = new Request.Builder()
                .addHeader(AGENT_HEADER, AGENT_HEADER_VALUE)
                .url(getAbsoluteUrl("agent/question/create"))
                .post(body)
                .build();

        Response response = client.newCall(request).execute();
        if (response.code() == 200) {
            return true;
        } else {
            return false;
        }
    }

    public static boolean questionExists(String url) throws IOException {
        String encodedString = Base64.getEncoder().encodeToString(url.getBytes());
        Request request = new Request.Builder()
                .addHeader(AGENT_HEADER, AGENT_HEADER_VALUE)
                .url(getAbsoluteUrl("agent/question/exists?url=" + encodedString))
                .build();

        try {
            Response response = client.newCall(request).execute();
            if (response.code() == 200) {
                String responseString = response.body().string();
                if (responseString.equals("true")) {
                    return true;
                } else if (responseString.equals("false")) {
                    return false;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }
}
