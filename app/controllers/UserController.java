package controllers;

import models.Password;
import models.User;
import models.Patient;

import play.data.DynamicForm;
import play.data.FormFactory;
import play.db.jpa.JPAApi;
import play.db.jpa.Transactional;
import play.mvc.Call;
import play.mvc.Controller;
import play.mvc.Result;

import javax.inject.Inject;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import static models.Password.getNewSalt;
import static play.libs.Json.toJson;

public class UserController extends Controller
{
    private final FormFactory formFactory;
    private final JPAApi jpaApi;

    @Inject
    public UserController(FormFactory formFactory, JPAApi jpaApi)
    {
        this.formFactory = formFactory;
        this.jpaApi = jpaApi;
    }

    @Transactional
    public Result passwordWizard()
    {
        Call route = routes.PatientController.getPagePasswordWizard();

        DynamicForm dynaForm = formFactory.form().bindFromRequest();

        String userEmail = dynaForm.get("userEmail");
        String newPassword = dynaForm.get("newPassword");
        String confirmPassword = dynaForm.get("confirmPassword");
        String cellPhone = dynaForm.get ("cellPhone");
        String cellPhone1 = "1" + cellPhone;

        if (!newPassword.equals(confirmPassword))
        {
            return redirect(routes.PatientController.get505());
        }

        List<Patient> patients = (List<Patient>) jpaApi.em().
                createQuery("select p from Patient p where p.email = :userEmail", Patient.class).
                setParameter("userEmail", userEmail).getResultList();


        if (patients.size() ==1)
        {
            Patient patient = patients.get(0);
            String patientID1 = patient.patientID;
            session("patientID1", patientID1);
            String patientID = session("patientID1");
            session("patientID", patientID);
        }
        else
            {
                return redirect(routes.PatientController.get404());
            }


        if (patients.size() == 1)
        {
            Patient patient = patients.get(0);

            if (patient.patientID.equals(session("patientID1")))
            {

                byte hash[] = null;
                byte salt[] = null;

                try
                {
                    salt = getNewSalt();
                    hash = Password.hashPassword(newPassword.toCharArray(), salt);

                    List<User> users = (List<User>)jpaApi.em().
                            createQuery("select u from User u where u.userEmail = :userEmail", User.class).
                            setParameter("userEmail", userEmail).getResultList();

                    if (users.size() == 1)
                    {
                        System.out.println("existing user found and will be updated");
                        User user = users.get(0);
                        user.patientID = session("patientID1");
                        user.password = hash;
                        user.passwordSalt = salt;
                        user.cellPhone = cellPhone1;
                        System.out.println(cellPhone1);
                        jpaApi.em().persist(user);

                        return redirect(routes.PatientController.getPageViewMyInfo());
                    }
                    else if (users.size() == 0)
                    {
                        System.out.println("New user will be created and added to the User table");
                        User user = new User();
                        user.patientID = session("patientID1");
                        user.password = hash;
                        user.passwordSalt = salt;
                        user.cellPhone = cellPhone1;
                        user.userEmail = userEmail;
                        jpaApi.em().persist(user);


                        return redirect(routes.PatientController.getPageViewMyInfo());
                    }
                    else
                    {
                        return redirect(routes.PatientController.get505());
                    }
                }
                catch (Exception e)
                {
                    System.out.println("error: " + e);
                    return redirect(route);
                }
            }
            else
            {
                return ok(toJson("whoops"));
            }
        }
        else
        {
            return redirect(routes.PatientController.get404());
        }
    }

    @Transactional
    public Result addUser()
    {
        DynamicForm dynaForm = formFactory.form().bindFromRequest();

        String firstName = dynaForm.get("firstName");
        String lastName = dynaForm.get("lastName");
        String dob = dynaForm.get("dob");
        String gender = dynaForm.get("gender");
        String address = dynaForm.get("address");
        String city = dynaForm.get("city");
        String state = dynaForm.get("state");
        String cellPhone = dynaForm.get("cellPhone");
        String zip = dynaForm.get("zip");
        String email = dynaForm.get("email");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        formatter = formatter.withLocale(Locale.US);
        LocalDate dob1 = LocalDate.parse(dob, formatter);

        Patient patient = new Patient();
        patient.firstName = firstName;
        patient.lastName = lastName;
        patient.dob = dob1;
        patient.gender = gender;
        patient.address = address;
        patient.city = city;
        patient.state = state;
        patient.cellPhone = cellPhone;
        patient.zip = zip;
        patient.email = email;

        jpaApi.em().persist(patient);

        return redirect(routes.PatientController.getPagePasswordWizard());
    }

    @Transactional
    public Result updatePatient()
    {
        Call route = routes.UserController.updatePatient();

        DynamicForm dynaForm = formFactory.form().bindFromRequest();

        String firstName = dynaForm.get("firstName");
        String lastName = dynaForm.get("lastName");
        String dob = dynaForm.get("dob");
        String gender = dynaForm.get("gender");
        String address = dynaForm.get("address");
        String city = dynaForm.get("city");
        String state = dynaForm.get("state");
        String cellPhone = dynaForm.get("cellPhone");
        String zip = dynaForm.get("zip");
        String email = dynaForm.get("email");

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        formatter = formatter.withLocale(Locale.US);
        LocalDate dob1 = LocalDate.parse(dob, formatter);
        String patientID = session("patientID");
        List<Patient> patients = (List<Patient>)jpaApi.em().
                createQuery("select p FROM Patient p WHERE p.patientID = :patientID" , Patient.class)
                .setParameter("patientID", patientID).getResultList();

        if(patients.size() == 1)
        {
            Patient patient = patients.get(0);
            patient.firstName = firstName;
            patient.lastName = lastName;
            patient.dob = dob1;
            patient.gender = gender;
            patient.address = address;
            patient.city = city;
            patient.state = state;
            patient.cellPhone = cellPhone;
            patient.zip = zip;
            patient.email = email;

            jpaApi.em().persist(patient);

            return redirect(routes.PatientController.getPageViewMyInfo());
        }
        else
        {
            return redirect(routes.PatientController.get404());
        }
    }

    public Result logout()
    {
        session().clear();
        return redirect(routes.PatientController.getPageLogin());
    }
}
