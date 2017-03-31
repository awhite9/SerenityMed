package controllers;

import models.Patient;
import models.PrescriptionReminderJoin;
import models.PrescriptionReminderManager;
import models.Prescription_Reminder;
import play.data.DynamicForm;
import play.data.FormFactory;
import play.db.jpa.JPAApi;
import play.db.jpa.Transactional;
import play.mvc.Controller;
import play.mvc.Result;

import javax.inject.Inject;
import java.time.LocalTime;
import java.util.List;


public class ReminderPrescriptionController extends Controller {

    private final FormFactory formFactory;
    private final JPAApi jpaApi;

    @Inject
    public ReminderPrescriptionController(FormFactory formFactory, JPAApi jpaApi) {
        this.formFactory = formFactory;
        this.jpaApi = jpaApi;
    }

    @Transactional(readOnly = true)
    public Result getReminderManager()
    {
        String patientID = session("patientID");
        if (patientID == null)
        {
            return redirect(routes.PatientController.getPageLogin());
        }
        else {

            Patient fullName = (Patient) jpaApi.em().createNativeQuery("select * from patient where patient_id = '" + patientID + "'", Patient.class).getSingleResult();


            List<PrescriptionReminderManager> reminder = (List<PrescriptionReminderManager>) jpaApi.em().createNativeQuery("select pr.REMINDER_ID, p.PATIENT_ID, p.first_name, p.cell_phone, pr.NEXT_REMINDER, f.frequency, pre.DOSAGE, m.MEDICATION_NAME, f.FREQUENCY_ID, pre.PRESCRIPTION_ID from patient p\n" +
                    "join prescription_reminder pr on p.PATIENT_ID = pr.PATIENT_ID\n" +
                    "join prescription pre on pr.PRESCRIPTION_ID = pre.PRESCRIPTION_ID\n" +
                    "join medication m on pre.MEDICATION_ID = m.MEDICATION_ID\n" +
                    "join frequency f on pre.FREQUENCY_ID = f.FREQUENCY_ID where p.PATIENT_ID = '" + patientID + "'", PrescriptionReminderManager.class).getResultList();

            List<Patient> patientList = (List<Patient>) jpaApi.em().createQuery("select p from Patient p", Patient.class).getResultList();

            List<PrescriptionReminderJoin> prescriptionJoinList = (List<PrescriptionReminderJoin>) jpaApi.em().createNativeQuery("select p.prescription_id,  p.dosage, m.MEDICATION_NAME, f.frequency from prescription p\n" +
                    "join medication m on m.MEDICATION_ID = p.MEDICATION_ID\n" +
                    "join frequency f on f.frequency_ID = p.FREQUENCY_ID where p.PATIENT_ID = '" + patientID + "'", PrescriptionReminderJoin.class).getResultList();

            return ok(views.html.prescriptionReminderPage.render(reminder, patientList, prescriptionJoinList, fullName));
        }
    }

    @Transactional
    public Result deleteReminder(Long reminderID)
    {
        Prescription_Reminder prescription_reminder = (Prescription_Reminder) jpaApi.em().createQuery("select pr from Prescription_Reminder pr where pr.reminderID = :Id").setParameter("Id", reminderID).getSingleResult();
        jpaApi.em().remove(prescription_reminder);
        return redirect(routes.ReminderPrescriptionController.getReminderManager());
    }

    @Transactional
    public Result addReminder()
    {
        String patientID = session("patientID");
        Prescription_Reminder prescriptionReminder = formFactory.form(Prescription_Reminder.class).bindFromRequest().get();
        prescriptionReminder.nextReminder = LocalTime.now();
        prescriptionReminder.patientID = patientID;
        jpaApi.em().persist(prescriptionReminder);
        return redirect(routes.ReminderPrescriptionController.getReminderManager());
    }
    @Transactional(readOnly = true)
    public Result editReminder(Long reminderID)
    {
        String patientID = session("patientID");
        if (patientID == null)
        {
            return redirect(routes.PatientController.getPageLogin());
        }
        else {

            Patient fullName = (Patient) jpaApi.em().createNativeQuery("select * from patient where patient_id = '" + patientID + "'", Patient.class).getSingleResult();

            List<PrescriptionReminderManager> reminder = (List<PrescriptionReminderManager>) jpaApi.em().createNativeQuery("select pr.REMINDER_ID, p.PATIENT_ID, p.first_name, p.cell_phone, pr.NEXT_REMINDER, f.frequency, pre.DOSAGE, m.MEDICATION_NAME, f.FREQUENCY_ID, pre.PRESCRIPTION_ID from patient p\n" +
                    "join prescription_reminder pr on p.PATIENT_ID = pr.PATIENT_ID\n" +
                    "join prescription pre on pr.PRESCRIPTION_ID = pre.PRESCRIPTION_ID\n" +
                    "join medication m on pre.MEDICATION_ID = m.MEDICATION_ID\n" +
                    "join frequency f on pre.FREQUENCY_ID = f.FREQUENCY_ID where p.PATIENT_ID = '" + patientID + "'", PrescriptionReminderManager.class).getResultList();

            List<Patient> patientList = (List<Patient>) jpaApi.em().createQuery("select p from Patient p", Patient.class).getResultList();

            List<PrescriptionReminderJoin> prescriptionJoinList = (List<PrescriptionReminderJoin>) jpaApi.em().createNativeQuery("select p.prescription_id,  p.dosage, m.MEDICATION_NAME, f.frequency from prescription p\n" +
                    "join medication m on m.MEDICATION_ID = p.MEDICATION_ID\n" +
                    "join frequency f on f.frequency_ID = p.FREQUENCY_ID where p.PATIENT_ID = '" + patientID + "'", PrescriptionReminderJoin.class).getResultList();

            PrescriptionReminderManager currentReminder = (PrescriptionReminderManager) jpaApi.em().createNativeQuery("select pr.REMINDER_ID, p.PATIENT_ID, p.first_name, p.cell_phone, pr.NEXT_REMINDER, f.frequency, pre.DOSAGE, m.MEDICATION_NAME, f.FREQUENCY_ID, pre.PRESCRIPTION_ID from patient p\n" +
                    "join prescription_reminder pr on p.PATIENT_ID = pr.PATIENT_ID\n" +
                    "join prescription pre on pr.PRESCRIPTION_ID = pre.PRESCRIPTION_ID\n" +
                    "join medication m on pre.MEDICATION_ID = m.MEDICATION_ID\n" +
                    "join frequency f on pre.FREQUENCY_ID = f.FREQUENCY_ID where pr.REMINDER_ID = :Id", PrescriptionReminderManager.class).setParameter("Id", reminderID).getSingleResult();

            return ok(views.html.prescriptionReminderEditPage.render(reminder, patientList, prescriptionJoinList, currentReminder, fullName));
        }
    }

    @Transactional
    public Result updateReminder()
    {
        String patientID = session("patientID");
        DynamicForm postedForm = formFactory.form().bindFromRequest();
        Long reminderID = new Long(postedForm.get("reminderID"));
        Long prescriptionID = new Long(postedForm.get("prescriptionID"));
        Prescription_Reminder reminder = (Prescription_Reminder) jpaApi.em().createQuery("select pr from Prescription_Reminder pr where pr.reminderID = :Id").setParameter("Id", reminderID).getSingleResult();

        reminder.patientID = patientID;
        reminder.prescriptionID = prescriptionID;
        reminder.nextReminder = LocalTime.now();

        jpaApi.em().persist(reminder);
        return redirect(routes.ReminderPrescriptionController.getReminderManager());

    }
}

