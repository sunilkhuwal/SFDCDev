import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.entity.StringEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicHeader;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

//For data import from properties file
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
	private static Header oauthHeader;
	private static Header prettyPrintHeader = new BasicHeader("X-PrettyPrint", "1");
	private static String contactId;

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
		oauthHeader = new BasicHeader("Authorization", "OAuth " + loginAccessToken) ;

		//Calling Query Method
		queryContacts();

		//For inserting the student Records
		insertStudents();

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
			//builder.setPath("/services/data/v39.0/query/").setParameter("q", "SELECT Id, Name, First_Name__c, LastName__c, Class__r.Id FROM Student__c LIMIT 5");

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

	public static void insertStudents() {

		//Student creation json
		JSONObject student = new JSONObject();
		student.put("Class__c", "a0Z0K000009xoz2");
		student.put("First_Name__c", "Paan singh");
		student.put("LastName__c", "Tomar");
		student.put("Name", "Paan singh Tomar");

		System.out.println("JSON for student insert: - " + student.toString(1));

		try {
			final URIBuilder builder = new URIBuilder(baseUri);
			builder.setPath("/services/data/v39.0/sobjects/Student__c/");
			final HttpPost post = new HttpPost(builder.build());
			post.setHeader("Authorization", "Bearer " + loginAccessToken);
			post.setHeader(oauthHeader);
			post.setHeader(prettyPrintHeader);

			StringEntity body = new StringEntity(student.toString());
			body.setContentType("application/json");
			post.setEntity(body);

			//Construct the objects needed for the request
			HttpClient httpClient = HttpClientBuilder.create().build();
			final HttpResponse response = httpclient.execute(post);

			//Process the results
			int statusCode = response.getStatusLine().getStatusCode();
			if(statusCode == 201) {
				String response_string = EntityUtils.toString(response.getEntity());
				JSONObject json = new JSONObject(response_string);

				//Store the retrieved contact id to use when we update the contact
				contactId = json.getString("id");
				System.out.println("New Contact id from response: " + contactId);
			} else {
				System.out.println("Insertion unsuccessful. Status code returned is " + statusCode + response.getEntity().toString());
			}

		} catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch(UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch(ClientProtocolException e) {
			e.printStackTrace();
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
}
