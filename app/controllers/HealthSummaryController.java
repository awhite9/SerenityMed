package controllers;


import models.*;
import play.data.FormFactory;
import play.db.jpa.JPAApi;
import play.db.jpa.Transactional;
import play.mvc.Controller;
import play.mvc.Result;

import javax.inject.Inject;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class HealthSummaryController extends Controller
{
    private final FormFactory formFactory;
    private final JPAApi jpaApi;

    @Inject
    public HealthSummaryController(FormFactory formFactory, JPAApi jpaApi) {
        this.formFactory = formFactory;
        this.jpaApi = jpaApi;
    }

    @Transactional(readOnly = true)
    public Result getHealthSummary()
    {
        String patientID = session("patientID");
        if (patientID == null)
        {
            return redirect(routes.PatientController.getPageLogin());
        }
        else {

            Patient fullName = (Patient) jpaApi.em().createNativeQuery("select * from patient where patient_id = '" + patientID + "'", Patient.class).getSingleResult();

            List<LineChart> lineChart = (List<LineChart>) jpaApi.em().createNativeQuery("select x.value val1, y.value val2,x.date_taken from (select pv.PATIENT_VITAL_ID, v.vital_name, pv.value, pv.date_taken from patient p \n" +
                    "join patient_vital pv on p.PATIENT_ID = pv.PATIENT_ID\n" +
                    "join vitals v on pv.VITAL_ID = v.VITAL_ID where v.vital_NAME = 'weight in lbs' and p.PATIENT_ID = '" + patientID + "') x join\n" +
                    "(select lp.LAB_PULLED_ID, l.lab_name, lp.value, lp.date_taken from patient p\n" +
                    "join lab_pulled lp on p.PATIENT_ID = lp.PATIENT_ID\n" +
                    "join lab l on lp.LAB_ID = l.LAB_ID where l.lab_name = 'Total cholesterol' and p.PATIENT_ID = '" + patientID + "') y\n" +
                    "on x.date_taken = y.date_taken order by date_taken asc", LineChart.class).getResultList();

            List<BarChart> barChart = (List<BarChart>) jpaApi.em().createNativeQuery("select x.value val1, y.value val2,x.date_taken from (select lp.LAB_PULLED_ID, l.lab_name, lp.value, lp.date_taken from patient p \n" +
                    "join lab_pulled lp on p.PATIENT_ID = lp.PATIENT_ID\n" +
                    "join lab l on lp.LAB_ID = l.LAB_ID where l.lab_name = 'Hemoglobin A1c' and p.PATIENT_ID = '" + patientID + "') x join\n" +
                    "(select lp.LAB_PULLED_ID, l.lab_name, lp.value, lp.date_taken from patient p\n" +
                    "join lab_pulled lp on p.PATIENT_ID = lp.PATIENT_ID\n" +
                    "join lab l on lp.LAB_ID = l.LAB_ID where l.lab_name = 'Glucose' and p.PATIENT_ID = '" + patientID + "') y\n" +
                    "on x.date_taken = y.date_taken\n" +
                    "order by date_taken asc", BarChart.class).getResultList();

            List<GoogleColumnChart> columnChart = new ArrayList<>();

            for (BarChart join : barChart) {
                GoogleColumnChart column = new GoogleColumnChart();
                String hem = join.val1.replace("%", "");
                float hemoglobin = Float.parseFloat(hem);
                float glucose = Float.parseFloat(join.val2);
                LocalDate dateTaken = join.dateTaken;
                System.out.println("hemoglobin: " + hemoglobin + " glucose: " + glucose);
                System.out.println(dateTaken);

                columnChart.add(column);
                column.setGlucose(glucose);
                column.setHemoglobin(hemoglobin);
                column.setDateTaken(dateTaken);
            }


            List<MedicalHistoryManager> currentMedicalHistory = (List<MedicalHistoryManager>) jpaApi.em().createNativeQuery("select mh.medical_history_id, mh.date_diagnosed, mh.date_resolved, mh.patient_id, mh.medical_condition_id, mc.mc_name from medical_history mh\n" +
                    "join medical_condition mc on mh.MEDICAL_CONDITION_ID = mc.MEDICAL_CONDITION_ID\n" +
                    "where mh.DATE_RESOLVED is null and mh.PATIENT_ID = '" + patientID + "'", MedicalHistoryManager.class).getResultList();

            List<MedicalHistoryManager> pastMedicalHistory = (List<MedicalHistoryManager>) jpaApi.em().createNativeQuery("select mh.medical_history_id, mh.date_diagnosed, mh.date_resolved, mh.patient_id, mh.medical_condition_id, mc.mc_name from medical_history mh\n" +
                    "join medical_condition mc on mh.MEDICAL_CONDITION_ID = mc.MEDICAL_CONDITION_ID\n" +
                    "where mh.DATE_RESOLVED is not null and mh.PATIENT_ID = '" + patientID + "'", MedicalHistoryManager.class).getResultList();

            List<PrescriptionManager> prescriptionManagerList = (List<PrescriptionManager>) jpaApi.em().createNativeQuery("select pre.PRESCRIPTION_ID, m.MEDICATION_ID, p.PATIENT_ID, p.FIRST_NAME, m.medication_name, pre.dosage, f.frequency, pre.frequency_id, d.doc_name, d.doctor_id, pharm.pharmacy_id, pharm.pharm_name, pre.date from patient p\n" +
                    "join prescription pre on p.PATIENT_ID = pre.PATIENT_ID\n" +
                    "join medication m on pre.MEDICATION_ID = m.MEDICATION_ID\n" +
                    "join pharmacy pharm on pre.PHARMACY_ID = pharm.PHARMACY_ID\n" +
                    "join doctor d on pre.DOCTOR_ID = d.DOCTOR_ID\n" +
                    "join frequency f on pre.FREQUENCY_ID = f.FREQUENCY_ID where p.PATIENT_ID = '" + patientID + "'", PrescriptionManager.class).getResultList();


            List<VitalManager> vitalManagerList = (List<VitalManager>) jpaApi.em().createNativeQuery("select pv.PATIENT_VITAL_ID, pv.VITAL_ID, v.vital_name, pv.value, pv.date_taken from patient_vital pv\n" +
                    "join vitals v on pv.VITAL_ID = v.VITAL_ID\n" +
                    "where pv.PATIENT_ID = '" + patientID + "'\n" +
                    "order by v.VITAL_NAME, pv.DATE_TAKEN desc\n", VitalManager.class).getResultList();

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
                        break;
                    case 2:
                        vitalItem.setDate2(vital.dateTaken);
                        vitalItem.setId2((vital.patientVitalID));
                        vitalItem.setValue2(vital.value);

                        break;
                    case 3:
                        vitalItem.setDate3(vital.dateTaken);
                        vitalItem.setId3((vital.patientVitalID));
                        vitalItem.setValue3(vital.value);

                        break;
                    default:
                        //we do not care about values past thr third one
                }
                vitalIndex++;
            }

            List<LabManager> labManagerList = (List<LabManager>) jpaApi.em().createNativeQuery("select lp.lab_pulled_id, lp.date_taken, lp.patient_id, lp.lab_id, lp.doctor_id, lp.value, l.lab_name, p.first_name, d.doc_name from lab_pulled lp\n" +
                    "join lab l on lp.lab_id = l.LAB_ID\n" +
                    "join patient p on p.patient_id = lp.patient_id\n" +
                    "join doctor d on lp.doctor_id = d.doctor_id\n" +
                    "where lp.PATIENT_ID = '" + patientID + "'\n" +
                    "order by l.lab_name", LabManager.class).getResultList();

            List<AllergyManager> allergyManagerList = (List<AllergyManager>) jpaApi.em().createNativeQuery("select pa.PATIENT_ALLERGY_ID, pa.patient_id, pa.allergy_id, p.first_name, a.allergy_name from patient_allergy pa\n" +
                    "join patient p on p.PATIENT_ID = pa.PATIENT_ID\n" +
                    "join allergies a on pa.ALLERGY_ID = a.ALLERGY_ID\n" +
                    "where p.PATIENT_ID = '" + patientID + "'", AllergyManager.class).getResultList();

            List<VaccinationManager> vaccinationManagers = (List<VaccinationManager>) jpaApi.em().createNativeQuery("select v.booster_required, vg.vaccination_given_id, vg.date, vg.doctor_id, vg.patient_id, p.first_name, vg.vaccine_id, v.vaccine_name, d.doc_name from vaccination_given vg\n" +
                    "join vaccination v on vg.VACCINE_ID = v.VACCINE_ID\n" +
                    "join doctor d on vg.DOCTOR_ID = d.DOCTOR_ID\n" +
                    "join patient p on vg.PATIENT_ID = p.PATIENT_ID\n" +
                    "where p.PATIENT_ID = '" + patientID + "'", VaccinationManager.class).getResultList();

            List<AppointmentManager> appointment = (List<AppointmentManager>) jpaApi.em().createNativeQuery("select a.APPOINTMENT_ID, a.PATIENT_ID, a.DOCTOR_ID, d.doc_name, d.DOC_SPECIALTY, a.appointment_date, a.appointment_time, p.first_name from appointment a\n" +
                    "join doctor d on a.DOCTOR_ID = d.DOCTOR_ID\n" +
                    "join patient p on a.PATIENT_ID = p.PATIENT_ID\n" +
                    "where p.PATIENT_ID = '" + patientID + "'", AppointmentManager.class).getResultList();

            return ok(views.html.healthSummaryPage.render(lineChart, barChart, currentMedicalHistory, pastMedicalHistory, prescriptionManagerList, vitalDates, vitalList, labManagerList, allergyManagerList, vaccinationManagers, appointment, columnChart, fullName));
        }
    }

    @Transactional
    public Result resolveConditionHS(Long medicalHistoryID)
    {
        Medical_History current = (Medical_History) jpaApi.em().createQuery("select mh from Medical_History mh where mh.medicalHistoryID = :Id").setParameter("Id", medicalHistoryID).getSingleResult();
        current.dateResolved = LocalDate.now();
        jpaApi.em().persist(current);
        return redirect(routes.HealthSummaryController.getHealthSummary());
    }


}
