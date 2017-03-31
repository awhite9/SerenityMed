package controllers;

import com.google.inject.Provider;

import daemon.Daemon;
import play.api.Application;
import play.api.libs.concurrent.Akka;
import play.mvc.Controller;
import play.mvc.Result;
import scala.concurrent.duration.Duration;
import scala.concurrent.duration.FiniteDuration;

import javax.inject.Inject;
import java.util.concurrent.TimeUnit;

public class DaemonController extends Controller
{
    Provider<Application> application;

    @Inject
    public DaemonController(Provider<Application> application)
    {
        this.application = application;

    }
    // this sets the time intervals that the run program run
    public Result start()
    {
        if (!Daemon.getRunning())
        {
            Daemon daemon = new Daemon();
            FiniteDuration delay = Duration.create(1, TimeUnit.SECONDS);
            FiniteDuration repeat = Duration.create(10, TimeUnit.SECONDS);

            Akka.system(application.get()).scheduler().
                    schedule(delay, repeat, daemon, Akka.system(application.get()).dispatcher());

            return ok("Started!");
        }
        else
        {
            return ok("Already Started!");
        }
    }
}

