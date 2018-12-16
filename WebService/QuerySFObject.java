import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

import dataProvider.ConfigFileReader;

public class QuerySFObject {
	
	static ConfigFileReader confReader = new ConfigFileReader();
	
	static final String USERNAME     = confReader.getUserName();
    static final String PASSWORD     =  confReader.getUserPassword();
    static final String TOKEN_URL =confReader.getApplicationUrl();
    static final String GRANTSERVICE = "/services/oauth2/token?grant_type=password";
    static final String CLIENTID     = confReader.getClientId();
    static final String CLIENTSECRET = confReader.getClientSecretKey();
    private static String REST_ENDPOINT = "/services/data" ;
    private static String API_VERSION = "/v44.0" ;
    private static String baseUri;
    private static String loginAccessToken;
    private static CloseableHttpClient httpclient;
    
    //Tasks
    //Query Contacts
    //Insert Student
    

	public static void main(String[] args) throws Exception {

        // login
        httpclient = HttpClients.createDefault();

        final List<NameValuePair> loginParams = new ArrayList<NameValuePair>();
        loginParams.add(new BasicNameValuePair("client_id", CLIENTID));
        loginParams.add(new BasicNameValuePair("client_secret", CLIENTSECRET));
        loginParams.add(new BasicNameValuePair("grant_type", "password"));
        loginParams.add(new BasicNameValuePair("username", USERNAME));
        loginParams.add(new BasicNameValuePair("password", PASSWORD));

        final HttpPost post = new HttpPost(TOKEN_URL);
        post.setEntity(new UrlEncodedFormEntity(loginParams));

        final HttpResponse response = httpclient.execute(post);

        //Verify response is HTTP OK
        final int statusCode = response.getStatusLine().getStatusCode();
        if (statusCode != HttpStatus.SC_OK) {
            System.out.println("Error authenticating to Force.com: "+statusCode);
            // Error is in EntityUtils.toString(response.getEntity()) 
            try{System.out.println(EntityUtils.toString(response.getEntity()));}
            catch(Exception e) {
            	
            }
            return;
        }
        
        String getResult = null;
        try {
            getResult = EntityUtils.toString(response.getEntity());
        } catch (IOException ioException) {
            ioException.printStackTrace();
        }
        
        System.out.println(getResult);
        
        JSONObject jsonObject = null;
        loginAccessToken = null;
        String loginInstanceUrl = null;
        try {
            jsonObject = (JSONObject) new JSONTokener(getResult).nextValue();
            loginAccessToken = jsonObject.getString("access_token");
            loginInstanceUrl = jsonObject.getString("instance_url");
        } catch (JSONException jsonException) {
            jsonException.printStackTrace();
        }
        System.out.println(response.getStatusLine());
        System.out.println("Successful login");
        System.out.println("  instance URL: "+loginInstanceUrl);
        System.out.println("  access token/session ID: "+loginAccessToken);

        baseUri = loginInstanceUrl + REST_ENDPOINT + API_VERSION ;

        //Calling Query Method
        queryContacts();
        
        
        // release connection
        post.releaseConnection();
	}
	
    // Query Contacts using REST HttpGet
    public static void queryContacts() {
        System.out.println("\n_______________ Contact QUERY _______________");
     
        try {
        	//Query contacts
            final URIBuilder builder = new URIBuilder(baseUri);
            builder.setPath("/services/data/v39.0/query/").setParameter("q", "SELECT Id, Name, FirstName, LastName FROM Contact LIMIT 5");

            final HttpGet get = new HttpGet(builder.build());
            get.setHeader("Authorization", "Bearer " + loginAccessToken);

            final HttpResponse queryResponse = httpclient.execute(get);
            HttpEntity entity = queryResponse.getEntity();
            String responseString = EntityUtils.toString(entity, "UTF-8");
            System.out.println(responseString);
        } catch(Exception e) {
        	e.printStackTrace();
        }
    }	
}
