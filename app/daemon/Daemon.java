package daemon;

import play.Logger;

import java.net.HttpURLConnection;
import java.net.URL;

import static play.mvc.Controller.session;

public class Daemon implements Runnable
{
    private static int runNumber = 0;
    private static boolean running = false;



    public static boolean getRunning()
    {
        return running;
    }

    //this function is called in the DaemonController
    @Override
    public void run()
    {

        try {

            //making self call to the project to get around the transaction issues
            URL url = new URL("http://localhost:9000/buttonStart");

            //Get the request setup
            HttpURLConnection request = (HttpURLConnection) url.openConnection();
            //Make the actual call to the web service
            request.setRequestMethod("POST");
            request.connect();
            request.getResponseCode();

        } catch (Exception e)
        {
            Logger.error("oh no! got some exception: " + e.getMessage());
        }


        running = true;
        System.out.println("Test: "+runNumber++);
    }
}


