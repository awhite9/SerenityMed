package controllers;



import com.fasterxml.jackson.databind.ObjectMapper;
import models.*;
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
import java.util.List;
import java.util.Locale;

public class PrescriptionController  extends Controller
{
    private final FormFactory formFactory;
    private final JPAApi jpaApi;

    @Inject
    public PrescriptionController(FormFactory formFactory, JPAApi jpaApi) {
        this.formFactory = formFactory;
        this.jpaApi = jpaApi;
    }

    @Transactional(readOnly = true)
    public Result getPrescriptionManager()
    {
        String patientID = session("patientID");
        if (patientID == null)
        {
            return redirect(routes.PatientController.getPageLogin());
        }
        else {
            Patient fullName = (Patient) jpaApi.em().createNativeQuery("select * from patient where patient_id = '" + patientID + "'", Patient.class).getSingleResult();

            List<PrescriptionManager> prescription = (List<PrescriptionManager>) jpaApi.em().createNativeQuery("select pre.PRESCRIPTION_ID, m.MEDICATION_ID, p.PATIENT_ID, p.FIRST_NAME, m.medication_name, pre.dosage, f.frequency, pre.frequency_id, d.doc_name, d.doctor_id, pharm.pharmacy_id, pharm.pharm_name, pre.date from patient p\n" +
                    "join prescription pre on p.PATIENT_ID = pre.PATIENT_ID\n" +
                    "join medication m on pre.MEDICATION_ID = m.MEDICATION_ID\n" +
                    "join pharmacy pharm on pre.PHARMACY_ID = pharm.PHARMACY_ID\n" +
                    "join doctor d on pre.DOCTOR_ID = d.DOCTOR_ID\n" +
                    "join frequency f on pre.FREQUENCY_ID = f.FREQUENCY_ID where p.PATIENT_ID = '" + patientID + "'", PrescriptionManager.class).getResultList();

            List<Patient> patientList = (List<Patient>) jpaApi.em().createQuery("select p from Patient p", Patient.class).getResultList();

            List<Frequency> frequencyList = (List<Frequency>) jpaApi.em().createQuery("select f from Frequency f", Frequency.class).getResultList();

            List<Medication> medicationList = (List<Medication>) jpaApi.em().createQuery("select m from Medication m", Medication.class).getResultList();

            List<Doctor> doctorList = (List<Doctor>) jpaApi.em().createQuery("select d from Doctor d", Doctor.class).getResultList();

            List<Pharmacy> pharmacyList = (List<Pharmacy>) jpaApi.em().createQuery("select ph from Pharmacy ph", Pharmacy.class).getResultList();


            return ok(views.html.pagePrescriptionManager.render(prescription, patientList, frequencyList, medicationList, doctorList, pharmacyList, fullName));
        }
    }

    @Transactional(readOnly = true)
    public Result getPrescriptionEdit(Long prescriptionID)
    {
        String patientID = session("patientID");
        if (patientID == null)
        {
            return redirect(routes.PatientController.getPageLogin());
        }
        else {

            Patient fullName = (Patient) jpaApi.em().createNativeQuery("select * from patient where patient_id = '" + patientID + "'", Patient.class).getSingleResult();

            List<PrescriptionManager> prescription = (List<PrescriptionManager>) jpaApi.em().createNativeQuery("select pre.PRESCRIPTION_ID, m.MEDICATION_ID, p.PATIENT_ID, p.FIRST_NAME, m.medication_name, pre.dosage, f.frequency, pre.frequency_id, d.doc_name, d.doctor_id, pharm.pharmacy_id, pharm.pharm_name, pre.date from patient p\n" +
                    "join prescription pre on p.PATIENT_ID = pre.PATIENT_ID\n" +
                    "join medication m on pre.MEDICATION_ID = m.MEDICATION_ID\n" +
                    "join pharmacy pharm on pre.PHARMACY_ID = pharm.PHARMACY_ID\n" +
                    "join doctor d on pre.DOCTOR_ID = d.DOCTOR_ID\n" +
                    "join frequency f on pre.FREQUENCY_ID = f.FREQUENCY_ID where p.PATIENT_ID = '" + patientID + "'", PrescriptionManager.class).getResultList();

            List<Patient> patientList = (List<Patient>) jpaApi.em().createQuery("select p from Patient p", Patient.class).getResultList();

            List<Frequency> frequencyList = (List<Frequency>) jpaApi.em().createQuery("select f from Frequency f", Frequency.class).getResultList();

            List<Medication> medicationList = (List<Medication>) jpaApi.em().createQuery("select m from Medication m", Medication.class).getResultList();

            List<Doctor> doctorList = (List<Doctor>) jpaApi.em().createQuery("select d from Doctor d", Doctor.class).getResultList();

            List<Pharmacy> pharmacyList = (List<Pharmacy>) jpaApi.em().createQuery("select ph from Pharmacy ph", Pharmacy.class).getResultList();


            PrescriptionManager currentPrescription = (PrescriptionManager) jpaApi.em().createNativeQuery("select pre.PRESCRIPTION_ID, m.MEDICATION_ID, p.PATIENT_ID, p.FIRST_NAME, m.medication_name, pre.dosage, f.frequency, pre.frequency_id, d.doc_name, d.doctor_id, pharm.pharmacy_id, pharm.pharm_name, pre.date from patient p\n" +
                    "join prescription pre on p.PATIENT_ID = pre.PATIENT_ID\n" +
                    "join medication m on pre.MEDICATION_ID = m.MEDICATION_ID\n" +
                    "join pharmacy pharm on pre.PHARMACY_ID = pharm.PHARMACY_ID\n" +
                    "join doctor d on pre.DOCTOR_ID = d.DOCTOR_ID\n" +
                    "join frequency f on pre.FREQUENCY_ID = f.FREQUENCY_ID where pre.PRESCRIPTION_ID = :Id", PrescriptionManager.class).setParameter("Id", prescriptionID).getSingleResult();


            return ok(views.html.pagePrescriptionEdit.render(prescription, patientList, frequencyList, medicationList, doctorList, pharmacyList, currentPrescription, fullName));
        }
    }


    @Transactional
    public Result addPrescription()
    {
        String patientID = session("patientID");
        DynamicForm postedForm = formFactory.form().bindFromRequest();
        String dosage = postedForm.get("dosage");
        String date = postedForm.get("date");
        Long medicationID = new Long(postedForm.get("medicationID"));
        Long pharmacyID = new Long(postedForm.get("pharmacyID"));
        Long doctorID = new Long(postedForm.get("doctorID"));
        Long frequencyID = new Long(postedForm.get("frequencyID"));

        java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd");
        formatter = formatter.withLocale(Locale.US);
        LocalDate dd = LocalDate.parse(date, formatter);
        Prescription prescription = new Prescription();

        prescription.patientID = patientID;
        prescription.dosage = dosage;
        prescription.date = dd;
        prescription.medicationID = medicationID;
        prescription.pharmacyID = pharmacyID;
        prescription.doctorID = doctorID;
        prescription.frequencyID = frequencyID;

        jpaApi.em().persist(prescription);
        return redirect(routes.PrescriptionController.getPrescriptionManager());
    }

    @Transactional
    public Result deletePrescription(Long prescriptionID)
    {
        Prescription prescription = (Prescription) jpaApi.em().createQuery("select p from Prescription p where p.prescriptionID = :Id").setParameter("Id", prescriptionID).getSingleResult();
        jpaApi.em().remove(prescription);
        return redirect(routes.PrescriptionController.getPrescriptionManager());
    }

    @Transactional
    public Result updatePrescription()
    {
        DynamicForm postedForm = formFactory.form().bindFromRequest();
        Long prescriptionID = new Long(postedForm.get("prescriptionID"));
        String dosage = postedForm.get("dosage");
        String date = postedForm.get("date");
        Long medicationID = new Long(postedForm.get("medicationID"));
        Long pharmacyID = new Long(postedForm.get("pharmacyID"));
        Long doctorID = new Long(postedForm.get("doctorID"));
        Long frequencyID = new Long(postedForm.get("frequencyID"));
        java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd");
        formatter = formatter.withLocale(Locale.US);
        LocalDate dd = LocalDate.parse(date, formatter);

        Prescription prescription = (Prescription) jpaApi.em().createQuery("select pre from Prescription pre where pre.prescriptionID = :Id").setParameter("Id", prescriptionID).getSingleResult();

        prescription.prescriptionID = prescriptionID;
        prescription.dosage = dosage;
        prescription.date = dd;
        prescription.medicationID = medicationID;
        prescription.pharmacyID = pharmacyID;
        prescription.doctorID = doctorID;
        prescription.frequencyID = frequencyID;

        jpaApi.em().persist(prescription);
        return redirect(routes.PrescriptionController.getPrescriptionManager());
    }

    @Transactional(readOnly = true)
    public Result spellingCorrection()
    {
        String patientID = session("patientID");
        if (patientID == null)
        {
            return redirect(routes.PatientController.getPageLogin());
        }
        else {
            Patient fullName = (Patient) jpaApi.em().createNativeQuery("select * from patient where patient_id = '" + patientID + "'", Patient.class).getSingleResult();

            DynamicForm postedForm = formFactory.form().bindFromRequest();
            String med = postedForm.get("med");

            List<PrescriptionManager> prescription = (List<PrescriptionManager>) jpaApi.em().createNativeQuery("select pre.PRESCRIPTION_ID, m.MEDICATION_ID, p.PATIENT_ID, p.FIRST_NAME, m.medication_name, pre.dosage, f.frequency, pre.frequency_id, d.doc_name, d.doctor_id, pharm.pharmacy_id, pharm.pharm_name, pre.date from patient p\n" +
                    "join prescription pre on p.PATIENT_ID = pre.PATIENT_ID\n" +
                    "join medication m on pre.MEDICATION_ID = m.MEDICATION_ID\n" +
                    "join pharmacy pharm on pre.PHARMACY_ID = pharm.PHARMACY_ID\n" +
                    "join doctor d on pre.DOCTOR_ID = d.DOCTOR_ID\n" +
                    "join frequency f on pre.FREQUENCY_ID = f.FREQUENCY_ID where p.PATIENT_ID = '" + patientID + "'", PrescriptionManager.class).getResultList();

            List<Patient> patientList = (List<Patient>) jpaApi.em().createQuery("select p from Patient p", Patient.class).getResultList();

            List<Frequency> frequencyList = (List<Frequency>) jpaApi.em().createQuery("select f from Frequency f", Frequency.class).getResultList();

            List<Medication> medicationList = (List<Medication>) jpaApi.em().createQuery("select m from Medication m", Medication.class).getResultList();

            List<Doctor> doctorList = (List<Doctor>) jpaApi.em().createQuery("select d from Doctor d", Doctor.class).getResultList();

            List<Pharmacy> pharmacyList = (List<Pharmacy>) jpaApi.em().createQuery("select ph from Pharmacy ph", Pharmacy.class).getResultList();


            RxNomSpelling jsonNode = null;
            try {
                //The web service I am calling
                String myURL = "https://rxnav.nlm.nih.gov/REST/spellingsuggestions.json?name=" + med;
                URL url = new URL(myURL);

                //Get the request setup
                HttpURLConnection request = (HttpURLConnection) url.openConnection();
                request.connect();

                ObjectMapper objectMapper = new ObjectMapper();
                jsonNode = objectMapper.readValue(url, RxNomSpelling.class);

            } catch (Exception e) {
                Logger.error("oh no! got some exception: " + e.getMessage());
            }

            if (jsonNode == null) {
                Logger.warn("oh no! got nothing back from url");
            }

            return ok(views.html.pagePrescriptionAddMedicine.render(prescription, patientList, frequencyList, medicationList, doctorList, pharmacyList, jsonNode, fullName));
        }
    }

    @Transactional
    public Result addMedication()
    {
        DynamicForm postedForm = formFactory.form().bindFromRequest();
        String med = postedForm.get("med");
        RxNomName drug = null;

        try
        {
            String myURL = "https://rxnav.nlm.nih.gov/REST/Prescribe/rxcui.json?name="+med;
            URL url = new URL(myURL);

            HttpURLConnection request = (HttpURLConnection) url.openConnection();
            request.connect();

            ObjectMapper objectMapper = new ObjectMapper();
            drug = objectMapper.readValue(url, RxNomName.class);

            System.out.println(drug);
        }
        catch (Exception e)
        {
            Logger.error("oh no! got some exception: " + e.getMessage());
        }

        if (drug == null)
        {
            Logger.warn("oh no! got nothing back from url");
        }

        Medication medication = new Medication();
        medication.medicationName = drug.getIdGroup().getName();
        for (String drugRXUI: drug.getIdGroup().getRxnormId())
        {
            medication.rxcui = Long.parseLong(drugRXUI);
        }

        jpaApi.em().persist(medication);
        return redirect(routes.PrescriptionController.getPrescriptionManager());
    }

    @Transactional(readOnly = true)
    public Result getDrugInteraction()
    {
        String patientID = session("patientID");
        if (patientID == null)
        {
            return redirect(routes.PatientController.getPageLogin());
        }
        else {
            List<Interaction> interaction = (List<Interaction>) jpaApi.em().createNativeQuery("select di.drug_interaction_id, m.MEDICATION_NAME as \"drug1Name\", di.rxcui, di.inter_rxcui, md.medication_name as \"drug2Name\", di.INTER_DESCRIPTION from drug_interaction di\n" +
                    "join medication m on m.RXCUI = di.RXCUI \n" +
                    "join medication md on md.RXCUI = di.INTER_RXCUI\n" +
                    "where di.rxcui in (select rxcui from prescription p  join medication m on p.MEDICATION_ID = m.MEDICATION_ID where patient_id = '" + patientID + "')\n" +
                    "and di.inter_rxcui in (select rxcui from prescription p  join medication m on p.MEDICATION_ID = m.MEDICATION_ID where patient_id = '" + patientID + "')\n" +
                    "and m.MEDICATION_NAME in (select medication_name from prescription p join medication m on p.MEDICATION_ID = m.MEDICATION_ID where patient_id = '" + patientID + "')\n" +
                    "and md.MEDICATION_NAME in (select medication_name from drug_interaction dri join medication md on dri.INTER_RXCUI = md.RXCUI)", Interaction.class).getResultList();

            return ok(views.html.drugInteractionPage.render(interaction));
        }

    }


}
