package controllers;


import com.amazonaws.services.dynamodbv2.xspec.S;
import models.*;
import play.data.DynamicForm;
import play.data.FormFactory;
import play.db.jpa.JPAApi;
import play.db.jpa.Transactional;
import play.mvc.Controller;
import play.mvc.Result;

import javax.inject.Inject;
import java.time.LocalDate;
import java.util.List;
import java.util.Locale;

public class VaccineController extends Controller {

    private final FormFactory formFactory;
    private final JPAApi jpaApi;

    @Inject
    public VaccineController(FormFactory formFactory, JPAApi jpaApi) {
        this.formFactory = formFactory;
        this.jpaApi = jpaApi;
    }

    @Transactional(readOnly = true)
    public Result getVaccineManager()
    {
        String patientID = session("patientID");
        if (patientID == null)
        {
            return redirect(routes.PatientController.getPageLogin());
        }
        else {

            Patient fullName = (Patient) jpaApi.em().createNativeQuery("select * from patient where patient_id = '" + patientID + "'", Patient.class).getSingleResult();

            List<VaccinationManager> vaccinationManagers = (List<VaccinationManager>) jpaApi.em().createNativeQuery("select v.booster_required, vg.vaccination_given_id, vg.date, vg.doctor_id, vg.patient_id, p.first_name, vg.vaccine_id, v.vaccine_name, d.doc_name from vaccination_given vg\n" +
                    "join vaccination v on vg.VACCINE_ID = v.VACCINE_ID\n" +
                    "join doctor d on vg.DOCTOR_ID = d.DOCTOR_ID\n" +
                    "join patient p on vg.PATIENT_ID = p.PATIENT_ID where p.PATIENT_ID = '" + patientID + "'", VaccinationManager.class).getResultList();

            List<Vaccination> vaccination = (List<Vaccination>) jpaApi.em().createQuery("select v from Vaccination v", Vaccination.class).getResultList();

            List<Patient> patientList = (List<Patient>) jpaApi.em().createQuery("select p from Patient p", Patient.class).getResultList();

            List<Doctor> doctorList = (List<Doctor>) jpaApi.em().createQuery("select d from Doctor d", Doctor.class).getResultList();


            return ok(views.html.vaccineManagerPage.render(vaccinationManagers, vaccination, patientList, doctorList, fullName));
        }
    }

    @Transactional
    public Result addVaccine()
    {
        String patientID = session("patientID");
        DynamicForm postedForm = formFactory.form().bindFromRequest();
        Long vaccineID = new Long(postedForm.get("vaccineID"));
        Long doctorID = new Long(postedForm.get("doctorID"));
        String date = postedForm.get("date");

        java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd");
        formatter = formatter.withLocale(Locale.US);
        LocalDate dd = LocalDate.parse(date, formatter);

        Vaccination_Given vaccination = new Vaccination_Given();
        vaccination.date = dd;
        vaccination.patientID = patientID;
        vaccination.vaccineID = vaccineID;
        vaccination.doctorID = doctorID;

        jpaApi.em().persist(vaccination);
        return redirect(routes.VaccineController.getVaccineManager());
    }

    @Transactional
    public Result deleteVaccine(Long vaccinationGivenID)
    {
        Vaccination_Given vaccination = (Vaccination_Given) jpaApi.em().createQuery("select vg from Vaccination_Given vg where vg.vaccinationGivenID = :Id").setParameter("Id", vaccinationGivenID).getSingleResult();
        jpaApi.em().remove(vaccination);
        return redirect(routes.VaccineController.getVaccineManager());
    }

    @Transactional
    public Result updateVaccine()
    {
        String patientID = session("patientID");
        DynamicForm postedForm = formFactory.form().bindFromRequest();
        Long vaccinationGivenID = new Long(postedForm.get("vaccinationGivenID"));
        Long vaccineID = new Long(postedForm.get("vaccineID"));
        Long doctorID = new Long(postedForm.get("doctorID"));
        String date = postedForm.get("date");

        java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd");
        formatter = formatter.withLocale(Locale.US);
        LocalDate dd = LocalDate.parse(date, formatter);

        Vaccination_Given vaccination = (Vaccination_Given) jpaApi.em().createQuery("select vg from Vaccination_Given vg where vg.vaccinationGivenID = :Id").setParameter("Id", vaccinationGivenID).getSingleResult();

        vaccination.date = dd;
        vaccination.patientID = patientID;
        vaccination.vaccineID = vaccineID;
        vaccination.doctorID = doctorID;

        jpaApi.em().persist(vaccination);
        return redirect(routes.VaccineController.getVaccineManager());
    }

    @Transactional(readOnly = true)
    public Result editVaccine(Long vaccinationGivenID)
    {
        String patientID = session("patientID");
        if (patientID == null)
        {
            return redirect(routes.PatientController.getPageLogin());
        }
        else {

            Patient fullName = (Patient) jpaApi.em().createNativeQuery("select * from patient where patient_id = '" + patientID + "'", Patient.class).getSingleResult();

            List<VaccinationManager> vaccinationManagers = (List<VaccinationManager>) jpaApi.em().createNativeQuery("select v.booster_required, vg.vaccination_given_id, vg.date, vg.doctor_id, vg.patient_id, p.first_name, vg.vaccine_id, v.vaccine_name, d.doc_name from vaccination_given vg\n" +
                    "join vaccination v on vg.VACCINE_ID = v.VACCINE_ID\n" +
                    "join doctor d on vg.DOCTOR_ID = d.DOCTOR_ID\n" +
                    "join patient p on vg.PATIENT_ID = p.PATIENT_ID where p.PATIENT_ID = '" + patientID + "'", VaccinationManager.class).getResultList();

            List<Vaccination> vaccination = (List<Vaccination>) jpaApi.em().createQuery("select v from Vaccination v", Vaccination.class).getResultList();

            List<Patient> patientList = (List<Patient>) jpaApi.em().createQuery("select p from Patient p", Patient.class).getResultList();

            List<Doctor> doctorList = (List<Doctor>) jpaApi.em().createQuery("select d from Doctor d", Doctor.class).getResultList();

            VaccinationManager currentVaccination = (VaccinationManager) jpaApi.em().createNativeQuery("select v.booster_required, vg.vaccination_given_id, vg.date, vg.doctor_id, vg.patient_id, p.first_name, vg.vaccine_id, v.vaccine_name, d.doc_name from vaccination_given vg\n" +
                    "join vaccination v on vg.VACCINE_ID = v.VACCINE_ID\n" +
                    "join doctor d on vg.DOCTOR_ID = d.DOCTOR_ID\n" +
                    "join patient p on vg.PATIENT_ID = p.PATIENT_ID where vg.vaccination_given_ID = :Id", VaccinationManager.class).setParameter("Id", vaccinationGivenID).getSingleResult();


            return ok(views.html.vaccineEditPage.render(vaccinationManagers, vaccination, patientList, doctorList, currentVaccination, fullName));
        }
    }
}
