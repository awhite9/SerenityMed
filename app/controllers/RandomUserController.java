package controllers;


import com.fasterxml.jackson.databind.ObjectMapper;
import models.RandomUser;
import play.Logger;
import play.mvc.Result;

import java.net.HttpURLConnection;
import java.net.URL;

import static play.libs.Json.toJson;
import static play.mvc.Results.ok;

public class RandomUserController
{
    public Result getRandomUser()
    {
        RandomUser randomUser = null;
        try
        {
            String myURL = "https://randomuser.me/api";

            URL url = new URL(myURL);

            HttpURLConnection request = (HttpURLConnection) url.openConnection();
            request.connect();


            ObjectMapper objectMapper = new ObjectMapper();
            randomUser = objectMapper.readerFor(RandomUser.class).readValue(url);
        } catch (Exception e)
        {
            Logger.error("oh no! got some exception: " + e.getMessage());
        }

        return ok(toJson(randomUser));
    }
}
