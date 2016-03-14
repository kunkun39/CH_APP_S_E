package com.changhong.common.service;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.MultiThreadedHttpConnectionManager;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.methods.MultipartPostMethod;

/**
 * User: Jack Wang
 * Date: 15-12-2
 * Time: 下午3:16
 */
public class HttpClientServiceImpl {

    private MultiThreadedHttpConnectionManager connectionManager;

    private int timeOutMilliSeconds = 60000;

    public HttpClientServiceImpl() {
        connectionManager = new MultiThreadedHttpConnectionManager();
        connectionManager.getParams().setConnectionTimeout(timeOutMilliSeconds);
    }

    public String httpGetRequestForString(String url) {
        HttpClient client = new HttpClient();
        client.getParams().setSoTimeout(timeOutMilliSeconds);
        client.getParams().setContentCharset("UTF-8");

        String sendUrl = url.replaceAll(" ", "%20");
        String response = "";
        GetMethod httpGet = new GetMethod(sendUrl);
        try {
            client.executeMethod(httpGet);
            response = httpGet.getResponseBodyAsString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            httpGet.releaseConnection();
        }
        return response;
    }

    public String httpPostRequest(MultipartPostMethod postMethod) {
        HttpClient client = new HttpClient(connectionManager);
        client.setConnectionTimeout(timeOutMilliSeconds);
        client.getParams().setContentCharset("UTF-8");

        int status = 0;
        String response = "";
        try {
            status = client.executeMethod(postMethod);
            if (status == HttpStatus.SC_OK) {
                response = postMethod.getResponseBodyAsString();
            } else {
                throw new RuntimeException("service is not avaible");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        } finally {
            postMethod.releaseConnection();
        }

        return response;
    }
}
