package controllers;

import com.amazonaws.services.sns.AmazonSNSClient;
import com.amazonaws.services.sns.model.MessageAttributeValue;
import com.amazonaws.services.sns.model.PublishRequest;
import com.amazonaws.services.sns.model.PublishResult;
import models.Password;
import models.Patient;
import models.User;
import play.data.DynamicForm;
import play.data.FormFactory;
import play.db.jpa.JPAApi;
import play.db.jpa.Transactional;
import play.mvc.Controller;
import play.mvc.Result;


import javax.inject.Inject;
import javax.persistence.TypedQuery;
import java.util.*;
import java.util.List;


import static play.libs.Json.toJson;


public class SMSAmazonController extends Controller
{
    private final FormFactory formFactory;
    private final JPAApi jpaApi;

    @Inject
    public SMSAmazonController(FormFactory formFactory, JPAApi jpaApi)
    {
        this.formFactory = formFactory;
        this.jpaApi = jpaApi;
    }

    @Transactional
    public Result twoFactorGenerator()
    {
        DynamicForm dynaForm = formFactory.form().bindFromRequest();

        String sessionEmail = dynaForm.get("sessionEmail");
        session("sessionEmail", sessionEmail);
        String password = dynaForm.get("password");
        session("password", password);
        String confirmPassword = dynaForm.get("confirmPassword");

        if(!password.equals(confirmPassword))
        {
            session().clear();
            return notFound();
        }

        List<User> users = (List<User>)jpaApi.em().
                createQuery("SELECT u FROM User u WHERE u.userEmail = :sessionEmail" , User.class)
                .setParameter("sessionEmail", sessionEmail).getResultList();

        if (users.size() == 1)
        {
            try
            {
                List<Patient> patients = (List<Patient>) jpaApi.em().
                        createQuery("select p from Patient p where p.email = :sessionEmail", Patient.class).
                        setParameter("sessionEmail", sessionEmail).getResultList();

                if (patients.size() == 1)
                {
                    Patient patient = patients.get(0);
                    session("patientID", patient.patientID);

                    byte[] salt = users.get(0).passwordSalt;
                    byte[] hash = Password.hashPassword(password.toCharArray(), salt);

                    String sql = "SELECT u FROM User u WHERE u.userEmail = :sessionEmail AND u.password = :password";
                    TypedQuery query = jpaApi.em().createQuery(sql, User.class);
                    query.setParameter("sessionEmail", sessionEmail);
                    query.setParameter("password", hash);
                    users = query.getResultList();

                    if (users.size() == 1)
                    {
                        User user = users.get(0);

                        session("cellPhone", user.cellPhone);
                        session("userEmail", user.userEmail);
                        session("userId", user.userId);

                        Random rand = new Random();
                        int num1, num2, num3, num4;

                        num1 = rand.nextInt(9) + 1;
                        num2 = rand.nextInt(9) + 1;
                        num3 = rand.nextInt(9) + 1;
                        num4 = rand.nextInt(9) + 1;

                        String twoFactor = num1 + "" + num2 + "" + num3 + "" + num4 + "";
                        session("twoFactor", twoFactor);

                        AmazonSNSClient snsClient = new AmazonSNSClient();
                        String message = "Your security verification code is: " + twoFactor;
                        String phoneNumber = "+" + session("cellPhone");
                        Map<String, MessageAttributeValue> smsAttributes =
                                new HashMap<String, MessageAttributeValue>();
                        smsAttributes.put("AWS.SNS.SMS.SenderID", new MessageAttributeValue()
                                .withStringValue("mySenderID") //The sender ID shown on the device.
                                .withDataType("String"));
                        smsAttributes.put("AWS.SNS.SMS.MaxPrice", new MessageAttributeValue()
                                .withStringValue("0.50") //Sets the max price to 0.50 USD.
                                .withDataType("Number"));
                        smsAttributes.put("AWS.SNS.SMS.SMSType", new MessageAttributeValue()
                                .withStringValue("Promotional") //Sets the type to promotional.
                                .withDataType("String"));
                        sendSMSMessage(snsClient, message, phoneNumber, smsAttributes);
                        System.out.println("two factor code is: " + twoFactor);

                        return redirect(routes.PatientController.getPageTwoFactor());
                    }
                    else
                    {
                        session().clear();
                        return redirect(routes.PatientController.getPageLogin());
                    }
                }
                else
                {
                    session().clear();
                    return redirect(routes.PatientController.getPageLogin());
                }
            }
            catch (Exception e)
            {
                session().clear();
                return notFound();
            }
        }

        else
        {
            session().clear();
            return redirect(routes.PatientController.get505());
        }
    }

    public static void sendSMSMessage(AmazonSNSClient snsClient, String message,
                                      String phoneNumber, Map<String, MessageAttributeValue> smsAttributes)
    {
        PublishResult result = snsClient.publish(new PublishRequest()
                .withMessage(message)
                .withPhoneNumber(phoneNumber)
                .withMessageAttributes(smsAttributes));
        System.out.println(result);
    }

    @Transactional
    public Result allowAccess()
    {
        DynamicForm dynaForm = formFactory.form().bindFromRequest();
        String userTwoFactor = dynaForm.get("userTwoFactor");
        session("userTwoFactor", userTwoFactor);
        String confirmTwoFactor = dynaForm.get("confirmTwoFactor");

        if (userTwoFactor.equals(confirmTwoFactor))
        {
            if (userTwoFactor.contentEquals(session("twoFactor")))
            {
                //return ok(toJson("Access granted: Patient ID is " + session("patientID")));
                return redirect(routes.HealthSummaryController.getHealthSummary());
            }
            else
            {
                session().clear();
                return redirect(routes.PatientController.getPageLogin());
            }
        }
        else
        {
            return redirect(routes.PatientController.getPageLogin());

        }
    }
}