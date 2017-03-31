package controllers;


import models.Patient;
import play.data.FormFactory;
import play.db.jpa.JPAApi;
import play.db.jpa.Transactional;
import play.mvc.Controller;
import play.mvc.Result;

import javax.inject.Inject;
import java.util.List;

import static play.libs.Json.toJson;

public class PatientController extends Controller
{
    private final FormFactory formFactory;
    private final JPAApi jpaApi;

    @Inject
    public PatientController(FormFactory formFactory, JPAApi jpaApi) {
        this.formFactory = formFactory;
        this.jpaApi = jpaApi;
    }
    @Transactional(readOnly = true)
    public Result getPatient() {
        List<Patient> patients = (List<Patient>) jpaApi.em().createQuery("select p from Patient p").getResultList();

        return ok(toJson(patients));
    }



    public Result get404()
    {
        return ok(views.html.page404.render());
    }

    public Result get505()
    {
        return ok(views.html.page505.render());
    }



    public Result getPageLogin()
    {
        session().clear();
        return ok(views.html.pageLogin.render());
    }






    public Result getRegistration()
    {
        return ok(views.html.pageRegister.render());
    }


    public Result getPageTwoFactor()
    {
        return ok(views.html.pagetwofactor.render());
    }

    public Result getPagePasswordWizard()
    {
        return ok(views.html.pagePasswordWizard.render());
    }

    @Transactional
    public Result getPageViewMyInfo()
    {
        String patientID = session("patientID");
        List<Patient> patient = (List<Patient>) jpaApi.em().
                createQuery("select p from Patient p where p.patientID = :patientID", Patient.class).
                setParameter("patientID", patientID).getResultList();

        return  ok(views.html.pageViewMyInfo.render(patient));
    }

    @Transactional (readOnly = true)
    public Result pageEditUser(String patientID)
    {
        session("patientID");
        Patient patient = (Patient) jpaApi.em().
                createQuery("select p from Patient p where p.patientID = :patientID")
                .setParameter("patientID", session("patientID")).getSingleResult();

        return  ok(views.html.pageUpdateUser.render(patient));
    }






}
