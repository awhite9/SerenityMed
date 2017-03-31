package controllers;

import models.*;
import play.data.DynamicForm;
import play.data.FormFactory;
import play.db.jpa.JPAApi;
import play.db.jpa.Transactional;
import play.mvc.Controller;
import play.mvc.Result;
import scala.concurrent.java8.FuturesConvertersImpl;

import javax.inject.Inject;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;


public class VitalController extends Controller {

    private final FormFactory formFactory;
    private final JPAApi jpaApi;

    @Inject
    public VitalController(FormFactory formFactory, JPAApi jpaApi) {
        this.formFactory = formFactory;
        this.jpaApi = jpaApi;
    }

    @Transactional(readOnly = true)
    public Result getVitalManager()
    {
        String patientID = session("patientID");
        if (patientID == null)
        {
            return redirect(routes.PatientController.getPageLogin());
        }
        else {

            Patient fullName = (Patient) jpaApi.em().createNativeQuery("select * from patient where patient_id = '" + patientID + "'", Patient.class).getSingleResult();

            List<VitalManager> vitalManagerList = (List<VitalManager>) jpaApi.em().createNativeQuery("select pv.PATIENT_VITAL_ID, pv.VITAL_ID, v.vital_name, pv.value, pv.date_taken from patient_vital pv\n" +
                    "join vitals v on pv.VITAL_ID = v.VITAL_ID\n" +
                    "where pv.PATIENT_ID = '" + patientID + "'\n" +
                    "order by v.VITAL_NAME, pv.DATE_TAKEN desc", VitalManager.class).getResultList();

            List<VitalDate> vitalDates = (List<VitalDate>) jpaApi.em().createNativeQuery("select pv.DATE_TAKEN from patient_vital pv\n" +
                    "where pv.PATIENT_ID = '" + patientID + "'\n" +
                    "group by pv.DATE_TAKEN desc limit 3", VitalDate.class).getResultList();


            List<VitalList> vitalList = new ArrayList<>();
            VitalList vitalItem = null;

            int vitalIndex = 1;

            for (VitalManager vital : vitalManagerList) {
                if (vitalItem == null || !vitalItem.getVitalName().equals(vital.vitalName)) {
                    vitalItem = new VitalList();
                    vitalList.add(vitalItem);
                    vitalItem.setVitalName(vital.vitalName);
                    vitalIndex = 1;
                }

                switch (vitalIndex) {
                    case 1:
                        vitalItem.setDate1(vital.dateTaken);
                        vitalItem.setId1((vital.patientVitalID));
                        vitalItem.setValue1(vital.value);
                        vitalItem.setVitalID(vital.vitalID);
                        break;
                    case 2:
                        vitalItem.setDate2(vital.dateTaken);
                        vitalItem.setId2((vital.patientVitalID));
                        vitalItem.setValue2(vital.value);
                        vitalItem.setVitalID(vital.vitalID);

                        break;
                    case 3:
                        vitalItem.setDate3(vital.dateTaken);
                        vitalItem.setId3((vital.patientVitalID));
                        vitalItem.setValue3(vital.value);
                        vitalItem.setVitalID(vital.vitalID);

                        break;
                    default:
                        //we do not care about values past thr third one
                }
                vitalIndex++;
            }
            return ok(views.html.vitalManagerPage.render(vitalList, vitalDates, fullName));
        }
    }
    @Transactional
    public Result addVitals()
    {
        String patientID = session("patientID");
        DynamicForm postedForm = formFactory.form().bindFromRequest();
        String value1 = postedForm.get("temp");
        String value2 = postedForm.get("pulse");
        String value3 = postedForm.get("bloodPressure");
        String value4 = postedForm.get("rr");
        String value5 = postedForm.get("weight");
        String date = postedForm.get("date");

        java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd");
        formatter = formatter.withLocale(Locale.US);
        LocalDate dd = LocalDate.parse(date, formatter);

        Patient_Vital temp = new Patient_Vital();
        temp.patientID = patientID;
        temp.vitalID = new Long("1");
        temp.value = value1;
        temp.dateTaken = dd;
        jpaApi.em().persist(temp);

        Patient_Vital pulse = new Patient_Vital();
        pulse.patientID = patientID;
        pulse.vitalID = new Long("2");
        pulse.value = value2;
        pulse.dateTaken = dd;
        jpaApi.em().persist(pulse);

        Patient_Vital bloodPressure = new Patient_Vital();
        bloodPressure.patientID = patientID;
        bloodPressure.vitalID = new Long("3");
        bloodPressure.value = value3;
        bloodPressure.dateTaken = dd;
        jpaApi.em().persist(bloodPressure);

        Patient_Vital rr = new Patient_Vital();
        rr.patientID = patientID;
        rr.vitalID = new Long("4");
        rr.value = value4;
        rr.dateTaken = dd;
        jpaApi.em().persist(rr);

        Patient_Vital weight = new Patient_Vital();
        weight.patientID = patientID;
        weight.vitalID = new Long("5");
        weight.value = value5;
        weight.dateTaken = dd;
        jpaApi.em().persist(weight);

        return redirect(routes.VitalController.getVitalManager());
    }

    @Transactional
    public Result deleteVitals()
    {
        String patientID = session("patientID");
        DynamicForm postedForm = formFactory.form().bindFromRequest();
        String date = postedForm.get("date");

        List<Patient_Vital> vital = (List<Patient_Vital>)jpaApi.em().createNativeQuery("select * from Patient_Vital pv where pv.date_Taken ='"+date+"' and pv.PATIENT_ID = '"+patientID+"'", Patient_Vital.class).getResultList();
        for(Patient_Vital removeVital: vital)
        {
            jpaApi.em().remove(removeVital);
        }

        return redirect(routes.VitalController.getVitalManager());
    }

    @Transactional(readOnly = true)
    public Result editVitals(Long vitalID)
    {
        String patientID = session("patientID");
        if (patientID == null)
        {
            return redirect(routes.PatientController.getPageLogin());
        }
        else {
            Patient fullName = (Patient) jpaApi.em().createNativeQuery("select * from patient where patient_id = '" + patientID + "'", Patient.class).getSingleResult();

            List<VitalManager> vitalManagerList = (List<VitalManager>) jpaApi.em().createNativeQuery("select pv.PATIENT_VITAL_ID, pv.VITAL_ID, v.vital_name, pv.value, pv.date_taken from patient_vital pv\n" +
                    "join vitals v on pv.VITAL_ID = v.VITAL_ID\n" +
                    "where pv.PATIENT_ID = '" + patientID + "'\n" +
                    "order by v.VITAL_NAME, pv.DATE_TAKEN desc", VitalManager.class).getResultList();

            List<VitalManager> currentVital = (List<VitalManager>) jpaApi.em().createNativeQuery("select pv.PATIENT_VITAL_ID, pv.PATIENT_ID, pv.VITAL_ID, v.vital_name, pv.value, pv.date_taken from patient_vital pv\n" +
                    "join vitals v on pv.VITAL_ID = v.VITAL_ID\n" +
                    "where pv.VITAL_ID ='"+vitalID+"' and pv.PATIENT_ID ='"+patientID+"'\n" +
                    "order by v.VITAL_NAME, pv.DATE_TAKEN desc limit 3", VitalManager.class).getResultList();

            VitalStringName currentName = (VitalStringName) jpaApi.em().createNativeQuery("select v.vital_name from vitals v where v.VITAL_ID = '" + vitalID + "'", VitalStringName.class).getSingleResult();

            List<VitalDate> vitalDates = (List<VitalDate>) jpaApi.em().createNativeQuery("select pv.DATE_TAKEN from patient_vital pv where pv.PATIENT_ID = '" + patientID + "' group by date_taken desc limit 3", VitalDate.class).getResultList();


            List<VitalList> vitalList = new ArrayList<>();
            VitalList vitalItem = null;

            int vitalIndex = 1;

            for (VitalManager vital : vitalManagerList) {
                if (vitalItem == null || !vitalItem.getVitalName().equals(vital.vitalName)) {
                    vitalItem = new VitalList();
                    vitalList.add(vitalItem);
                    vitalItem.setVitalName(vital.vitalName);
                    vitalIndex = 1;
                }

                switch (vitalIndex) {
                    case 1:
                        vitalItem.setDate1(vital.dateTaken);
                        vitalItem.setId1((vital.patientVitalID));
                        vitalItem.setValue1(vital.value);
                        vitalItem.setVitalID(vital.vitalID);
                        break;
                    case 2:
                        vitalItem.setDate2(vital.dateTaken);
                        vitalItem.setId2((vital.patientVitalID));
                        vitalItem.setValue2(vital.value);
                        vitalItem.setVitalID(vital.vitalID);

                        break;
                    case 3:
                        vitalItem.setDate3(vital.dateTaken);
                        vitalItem.setId3((vital.patientVitalID));
                        vitalItem.setValue3(vital.value);
                        vitalItem.setVitalID(vital.vitalID);

                        break;
                    default:
                        //we do not care about values past thr third one
                }
                vitalIndex++;
            }
            return ok(views.html.vitalManagerEdit.render(vitalList, vitalDates, currentVital, currentName, fullName));
        }
    }

    @Transactional
    public Result updateVitals()
    {
        DynamicForm postedForm = formFactory.form().bindFromRequest();
        Long patientVitalID1 = new Long(postedForm.get("currentPatientVitalID1"));
        String currentValue1 = postedForm.get("currentValue1");
        Long patientVitalID2 = new Long(postedForm.get("currentPatientVitalID2"));
        String currentValue2 = postedForm.get("currentValue2");
        Long patientVitalID3 = new Long(postedForm.get("currentPatientVitalID3"));
        String currentValue3 = postedForm.get("currentValue3");

        Patient_Vital vital1  = (Patient_Vital) jpaApi.em().createQuery("select pv from Patient_Vital pv where pv.patientVitalID = :Id").setParameter("Id", patientVitalID1).getSingleResult();
        vital1.value = currentValue1;
        System.out.println(vital1.value);
        jpaApi.em().persist(vital1);

        Patient_Vital vital2  = (Patient_Vital) jpaApi.em().createQuery("select pv from Patient_Vital pv where pv.patientVitalID = :Id").setParameter("Id", patientVitalID2).getSingleResult();
        vital2.value = currentValue2;
        System.out.println(vital2.value);
        jpaApi.em().persist(vital2);

        Patient_Vital vital3  = (Patient_Vital) jpaApi.em().createQuery("select pv from Patient_Vital pv where pv.patientVitalID = :Id").setParameter("Id", patientVitalID3).getSingleResult();
        vital3.value = currentValue3;
        System.out.println(vital3.value);
        jpaApi.em().persist(vital3);



        return redirect(routes.VitalController.getVitalManager());
    }
}

