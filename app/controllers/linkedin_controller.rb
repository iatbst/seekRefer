class LinkedinController < ApplicationController
  require 'oauth2'
  API_KEY = 'ha1rrsh6bfpk' #Your app's API key
  API_SECRET = 'uWX6psXl4ZmlNnXL' #Your app's API secret
  REDIRECT_URI = 'http://localhost:3000/linkedin/accept' #Redirect users after authentication to this path, ensure that you have set up your routes to handle the callbacks
  STATE = SecureRandom.hex(15) #A unique long string that is not easy to guess
   
  #Instantiate your OAuth2 client object
  def client
    OAuth2::Client.new(
       API_KEY,
       API_SECRET,
       :authorize_url => "/uas/oauth2/authorization?response_type=code", #LinkedIn's authorization path
       :token_url => "/uas/oauth2/accessToken", #LinkedIn's access token path
       :site => "https://www.linkedin.com"
     )
  end
   
  def index
    authorize
  end
 
  def authorize
    #Redirect your user in order to authenticate
    redirect_to client.auth_code.authorize_url(:scope => 'r_fullprofile r_emailaddress r_network',
                                               :state => STATE,
                                               :redirect_uri => REDIRECT_URI)
  end
 
  # This method will handle the callback once the user authorizes your application
  def accept
      #Fetch the 'code' query parameter from the callback
          code = params[:code]
          state = params[:state]
           
          if !state.eql?(STATE)
             #Reject the request as it may be a result of CSRF
          else          
            #Get token object, passing in the authorization code from the previous step
            token = client.auth_code.get_token(code, :redirect_uri => REDIRECT_URI)
           
            #Use token object to create access token for user
            #(this is required so that you provide the correct param name for the access token)
            access_token = OAuth2::AccessToken.new(client, token.token, {
              :mode => :query,
              :param_name => "oauth2_access_token",
              })
 
            #Use the access token to make an authenticated API call
            #api = 'https://api.linkedin.com/v1/companies/1337:(id,name,universal-name,website-url,industries,description,logo-url,employee-count-range)'
            api = 'https://api.linkedin.com/v1/company-search:(facets:(code,buckets:(code,name,count)),companies:(id,name,universal-name,website-url,industries,description,logo-url,employee-count-range,locations:(address:(region-code))))?facets=location,industry&facet=location,us:84&facet=industry,6&count=300&start=20'
            #api = 'https://api.linkedin.com/v1/companies/1337:(id,name,ticker,description)'
            @response = access_token.get(api)
 
            #Print body of response to command line window
            puts @response.body
            
            
            hashs = Hash.from_xml(@response.body)
            
            if hashs.nil?
              puts "1 Hash is NULL !!!"
            elsif hashs["company-search"].nil?
              puts "2 Hash is NULL !!!"
            end
            
            hashs["company_search"]["companies"]["company"].each do |hash|
            
            
            
            #hash = Hash.from_xml(@response.body)
            if hash["industries"]["total"] == "1"
              in_id = hash["industries"]["industry"]["code"]
            else
              in_id = hash["industries"]["industry"][0]["code"]
            end
            id = Industry.find_by_code(in_id).id
            
            company = Company.new(name: hash["name"],
                                  description: hash["description"],
                                  website: hash["website_url"],
                                  logo_url: hash["logo_url"],
                                  industry_id: id,
                                  employee_count_range: hash["employee_count_range"]["name"])
            company.logo_from_url hash["logo_url"] 
            company.save
            
            end
 
            # Handle HTTP responses
            case @response
              when Net::HTTPUnauthorized
                # Handle 401 Unauthorized response
              when Net::HTTPForbidden
                # Handle 403 Forbidden response
            end
        end
    end

end
  

