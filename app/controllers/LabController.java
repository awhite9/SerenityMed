package controllers;


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

public class LabController extends Controller {

    private final FormFactory formFactory;
    private final JPAApi jpaApi;

    @Inject
    public LabController(FormFactory formFactory, JPAApi jpaApi) {
        this.formFactory = formFactory;
        this.jpaApi = jpaApi;
    }

    @Transactional(readOnly = true)
    public Result getLabManager()
    {
        String patientID = session("patientID");

        List<LabManager> labManagerList = (List<LabManager>) jpaApi.em().createNativeQuery("select lp.lab_pulled_id, lp.date_taken, lp.patient_id, lp.lab_id, lp.doctor_id, lp.value, l.lab_name, p.first_name, d.doc_name from lab_pulled lp\n" +
                "join lab l on lp.lab_id = l.LAB_ID\n" +
                "join patient p on p.patient_id = lp.patient_id\n" +
                "join doctor d on lp.doctor_id = d.doctor_id\n" +
                " where p.PATIENT_ID = '"+11+"'" +
                "order by l.lab_name", LabManager.class).getResultList();

        List<Lab> labList = jpaApi.em().createQuery("select l from Lab l", Lab.class).getResultList();

        List<Patient> patientList =(List<Patient>) jpaApi.em().createNativeQuery("select * from patient p", Patient.class).getResultList();

        List<Doctor> doctorList = (List<Doctor>) jpaApi.em().createNativeQuery("select * from doctor d", Doctor.class).getResultList();


        return ok(views.html.labManagerPage.render(labManagerList, labList, patientList, doctorList));

    }

    @Transactional
    public Result deleteLab(Long labPulledID)
    {
        Lab_Pulled deleteLab = (Lab_Pulled) jpaApi.em().createQuery("select lp from Lab_Pulled lp where lp.labPulledID = :ID").setParameter("ID", labPulledID).getSingleResult();
        jpaApi.em().remove(deleteLab);
        return redirect(routes.LabController.getLabManager());
    }
    @Transactional
    public Result addLab()
    {
        String patientID = session("patientID");
        DynamicForm postedForm = formFactory.form().bindFromRequest();

        LocalDate dateTaken = LocalDate.parse(postedForm.get("date"));

        Lab_Pulled lab = formFactory.form(Lab_Pulled.class).bindFromRequest().get();
        lab.dateTaken = dateTaken;
        lab.patientID = "11";

        jpaApi.em().persist(lab);
        return redirect(routes.LabController.getLabManager());
    }
    @Transactional
    public Result editLab(Long labPulledID)
    {
        String patientID = session("patientID");

        List<LabManager> labManagerList = (List<LabManager>) jpaApi.em().createNativeQuery("select lp.lab_pulled_id, lp.date_taken, lp.patient_id, lp.lab_id, lp.doctor_id, lp.value, l.lab_name, p.first_name, d.doc_name from lab_pulled lp\n" +
                "join lab l on lp.lab_id = l.LAB_ID\n" +
                "join patient p on p.patient_id = lp.patient_id\n" +
                "join doctor d on lp.doctor_id = d.doctor_id\n" +
                " where p.PATIENT_ID = '"+11+"'" +
                "order by l.lab_name", LabManager.class).getResultList();

        LabManager currentLab = (LabManager) jpaApi.em().createNativeQuery("select lp.lab_pulled_id, lp.date_taken, lp.patient_id, lp.lab_id, lp.doctor_id, lp.value, l.lab_name, p.first_name, d.doc_name from lab_pulled lp\n" +
                "      join lab l on lp.lab_id = l.LAB_ID\n" +
                "      join patient p on p.patient_id = lp.patient_id\n" +
                "      join doctor d on lp.doctor_id = d.doctor_id\n" +
                "      where lp.lab_pulled_id = :labPulledID", LabManager.class).setParameter("labPulledID", labPulledID).getSingleResult();

        List<Lab> labList =  jpaApi.em().createQuery("select l from Lab l", Lab.class).getResultList();

        List<Doctor> doctorList =  jpaApi.em().createQuery("select d from Doctor d", Doctor.class).getResultList();

        List<Patient> patientList =  jpaApi.em().createQuery("select p from Patient p", Patient.class).getResultList();

        List<Lab_Pulled> labPulledList = jpaApi.em().createQuery("select lp from Lab_Pulled lp", Lab_Pulled.class).getResultList();

        return ok(views.html.labEditPage.render(labManagerList,currentLab,labList,doctorList,patientList,labPulledList));
    }

    @Transactional
    public Result updateLab()
    {
        String patientID = session("patientID");

        DynamicForm postedForm = formFactory.form().bindFromRequest();

        Long labPulledID = new Long(postedForm.get("labPulledID"));
        Long doctorID = new Long(postedForm.get("doctorID"));
        String value = postedForm.get("value");
        LocalDate dateTaken = LocalDate.parse(postedForm.get("date"));
        System.out.println(labPulledID);
        Lab_Pulled lab_pulled = (Lab_Pulled) jpaApi.em().createQuery("select lp from Lab_Pulled lp where lp.labPulledID = :ID").setParameter("ID", labPulledID).getSingleResult();

        lab_pulled.patientID = "11";
        lab_pulled.value = value;
        lab_pulled.doctorID=doctorID;
        lab_pulled.labPulledID=labPulledID;
        lab_pulled.dateTaken=dateTaken;

        jpaApi.em().persist(lab_pulled);

        return redirect(routes.LabController.getLabManager());
    }

}
