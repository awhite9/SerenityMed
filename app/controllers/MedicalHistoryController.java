package controllers;


import models.*;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;
import org.w3c.dom.Document;
import play.Logger;
import play.data.DynamicForm;
import play.data.FormFactory;
import play.db.jpa.JPAApi;
import play.db.jpa.Transactional;
import play.mvc.Controller;
import play.mvc.Result;

import javax.inject.Inject;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class MedicalHistoryController  extends Controller
{
    private final FormFactory formFactory;
    private final JPAApi jpaApi;


    @Inject
    public MedicalHistoryController(FormFactory formFactory, JPAApi jpaApi) {
        this.formFactory = formFactory;
        this.jpaApi = jpaApi;
    }

    @Transactional(readOnly = true)
    public Result getMoreInfo()
    {
        String patientID = session("patientID");
        if (patientID == null)
        {
            return redirect(routes.PatientController.getPageLogin());
        }
        else {
            Patient fullName = (Patient) jpaApi.em().createNativeQuery("select * from patient where patient_id = '" + patientID + "'", Patient.class).getSingleResult();

            //hard coded in the health conditions, will be pulling list of health conditions from database in DAC
            List<MedLine> fullSummery = new ArrayList<>();


            List<MedLineHealthCondition> currentMedCondition = (List<MedLineHealthCondition>) jpaApi.em().createNativeQuery("select mh.medical_history_id, mc.mc_name, mc.mc_description, mc.mc_url from medical_history mh\n" +
                    "join medical_condition mc on mc.MEDICAL_CONDITION_ID = mh.MEDICAL_CONDITION_ID\n" +
                    "where date_resolved is null and mh.PATIENT_ID = '" + patientID + "'", MedLineHealthCondition.class).getResultList();

            for (MedLineHealthCondition conditionList : currentMedCondition) {


                int indexPosition = 1;
                Document doc = null;
                try {
                    //loops though, making a new API call for every health condition
                    String myURL = "https://wsearch.nlm.nih.gov/ws/query?db=healthTopics&term=" + conditionList.name;

                    URL url = new URL(myURL);

                    HttpURLConnection request = (HttpURLConnection) url.openConnection();
                    request.connect();
                    //This contains all the xml info from the API
                    doc = play.libs.XML.fromInputStream(request.getInputStream(), null);

                    while (!doc.getFirstChild().getChildNodes().item(13).getChildNodes().item(1).getChildNodes().item(indexPosition).getAttributes().getNamedItem("name").getFirstChild().getTextContent().contentEquals("FullSummary")) {
                        //with MedLine even numbered nodes are null - so increment by 2 to avoid null pointer exception
                        indexPosition += 2;
                        if (indexPosition > doc.getFirstChild().getChildNodes().item(13).getChildNodes().item(1).getChildNodes().getLength()) {
                            //if none of the nodes in the content node have the name "FullSummary", break the while loop and set indexPosition to 1, avoiding blowup
                            indexPosition = 1;
                            break;
                        }
                    }

                } catch (Exception e) {
                    Logger.error("oh no! got some exception: " + e.getMessage());
                }

                String fullSummaryString = doc.getFirstChild().getChildNodes().item(13).getChildNodes().item(1).getChildNodes().item(indexPosition).getTextContent();
                String readMoreURL = doc.getFirstChild().getChildNodes().item(13).getChildNodes().item(1).getAttributes().getNamedItem("url").getTextContent();
                String conditionName = conditionList.name.toUpperCase();
                MedLine summary = new MedLine(conditionName, fullSummaryString, readMoreURL);
                fullSummery.add(summary);
            }

            return ok(views.html.moreInfoPage.render(fullSummery, fullName));
        }
    }

    @Transactional(readOnly = true)
    public Result getHealthConditionManager()
    {
        String patientID = session("patientID");
        if (patientID == null)
        {
            return redirect(routes.PatientController.getPageLogin());
        }
        else {

            Patient fullName = (Patient) jpaApi.em().createNativeQuery("select * from patient where patient_id = '" + patientID + "'", Patient.class).getSingleResult();

            List<MedicalHistoryManager> currentMedicalHistory = (List<MedicalHistoryManager>) jpaApi.em().createNativeQuery("select mh.medical_history_id, mh.date_diagnosed, mh.date_resolved, mh.patient_id, mh.medical_condition_id, mc.mc_name from medical_history mh\n" +
                    "join medical_condition mc on mh.MEDICAL_CONDITION_ID = mc.MEDICAL_CONDITION_ID\n" +
                    "where mh.DATE_RESOLVED is null and mh.PATIENT_ID = '" + patientID + "'", MedicalHistoryManager.class).getResultList();

            List<MedicalHistoryManager> pastMedicalHistory = (List<MedicalHistoryManager>) jpaApi.em().createNativeQuery("select mh.medical_history_id, mh.date_diagnosed, mh.date_resolved, mh.patient_id, mh.medical_condition_id, mc.mc_name from medical_history mh\n" +
                    "join medical_condition mc on mh.MEDICAL_CONDITION_ID = mc.MEDICAL_CONDITION_ID\n" +
                    "where mh.DATE_RESOLVED is not null and mh.PATIENT_ID = '" + patientID + "'", MedicalHistoryManager.class).getResultList();

            List<Patient> patientList = (List<Patient>) jpaApi.em().createQuery("select p from Patient p", Patient.class).getResultList();

            List<Medical_Condition> medCondition = (List<Medical_Condition>) jpaApi.em().createQuery("select mc from Medical_Condition mc", Medical_Condition.class).getResultList();


            return ok(views.html.healthConditionManagerPage.render(currentMedicalHistory, pastMedicalHistory, patientList, medCondition, fullName));
        }
    }

    @Transactional
    public Result deleteCondition(Long medicalHistoryID) {
        Medical_History condition = (Medical_History) jpaApi.em().createQuery("select mh from Medical_History mh where mh.medicalHistoryID = :Id").setParameter("Id", medicalHistoryID).getSingleResult();
        jpaApi.em().remove(condition);
        return redirect(routes.MedicalHistoryController.getHealthConditionManager());
    }

    @Transactional
    public Result addMedicalHistory()
    {
        String patientID = session("patientID");
        DynamicForm dynaForm = formFactory.form().bindFromRequest();
        Long medicalConditionID = new Long(dynaForm.get("medicalConditionID"));
        String dateDiagnosed = dynaForm.get("dateDiagnosed");

        java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd");
        formatter = formatter.withLocale(Locale.US);
        LocalDate dd = LocalDate.parse(dateDiagnosed, formatter);

        Medical_History newCurrent = new Medical_History();
        newCurrent.medicalConditionID = medicalConditionID;
        newCurrent.patientID = patientID;
        newCurrent.dateDiagnosed = dd;
        newCurrent.dateResolved = null;
        jpaApi.em().persist(newCurrent);
        return redirect(routes.MedicalHistoryController.getHealthConditionManager());
    }

    @Transactional
    public Result resolveCondition(Long medicalHistoryID) {
        Medical_History current = (Medical_History) jpaApi.em().createQuery("select mh from Medical_History mh where mh.medicalHistoryID = :Id").setParameter("Id", medicalHistoryID).getSingleResult();
        current.dateResolved = LocalDate.now();
        jpaApi.em().persist(current);
        return redirect(routes.MedicalHistoryController.getHealthConditionManager());
    }




}
