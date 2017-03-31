package controllers;


import models.Allergies;
import models.AllergyManager;
import models.Patient;
import models.Patient_Allergy;
import play.data.FormFactory;
import play.db.jpa.JPAApi;
import play.db.jpa.Transactional;
import play.mvc.Controller;
import play.mvc.Result;

import javax.inject.Inject;
import java.util.List;

public class AllergyController  extends Controller {

    private final FormFactory formFactory;
    private final JPAApi jpaApi;

    @Inject
    public AllergyController(FormFactory formFactory, JPAApi jpaApi) {
        this.formFactory = formFactory;
        this.jpaApi = jpaApi;
    }

    @Transactional(readOnly = true)
    public Result getAllergyManager() {
        String patientID = session("patientID");
        //cant get to pages without logging in
        if (patientID == null)
        {
            return redirect(routes.PatientController.getPageLogin());
        }
        else {

            Patient fullName = (Patient) jpaApi.em().createNativeQuery("select * from patient where patient_id = '" + patientID + "'", Patient.class).getSingleResult();
            List<AllergyManager> allergyManagerList = (List<AllergyManager>) jpaApi.em().createNativeQuery("select pa.PATIENT_ALLERGY_ID, pa.patient_id, pa.allergy_id, p.first_name, a.allergy_name from patient_allergy pa\n" +
                    "join patient p on p.PATIENT_ID = pa.PATIENT_ID\n" +
                    "join allergies a on pa.ALLERGY_ID = a.ALLERGY_ID\n" +
                    "where p.PATIENT_ID = '" + patientID + "'", AllergyManager.class).getResultList();

            List<Allergies> allergy = (List<Allergies>) jpaApi.em().createQuery("select a from Allergies a", Allergies.class).getResultList();

            List<Patient> patientList = (List<Patient>) jpaApi.em().createQuery("select p from Patient p", Patient.class).getResultList();


            return ok(views.html.allergyManagerPage.render(allergyManagerList, allergy, patientList, fullName));
        }

    }

    @Transactional
    public Result addAllergy()
    {
        String patientID = session("patientID");
        Patient_Allergy allergy = formFactory.form(Patient_Allergy.class).bindFromRequest().get();
        allergy.patientID = patientID;
        jpaApi.em().persist(allergy);
        return redirect(routes.AllergyController.getAllergyManager());
    }

    @Transactional
    public Result deleteAllergy(Long patientAllergyID)
    {
        Patient_Allergy allergy = (Patient_Allergy) jpaApi.em().createQuery("select pa from Patient_Allergy pa where pa.patientAllergyID = :Id").setParameter("Id", patientAllergyID).getSingleResult();
        jpaApi.em().remove(allergy);
        return redirect(routes.AllergyController.getAllergyManager());
    }
}
