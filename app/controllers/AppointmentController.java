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
import java.time.LocalTime;
import java.util.List;


public class AppointmentController extends Controller {

    private final FormFactory formFactory;
    private final JPAApi jpaApi;

    @Inject
    public AppointmentController(FormFactory formFactory, JPAApi jpaApi) {
        this.formFactory = formFactory;
        this.jpaApi = jpaApi;
    }

    @Transactional(readOnly = true)
    public Result getAppointmentManager()
    {
        String patientID = session("patientID");

        List<AppointmentManager> appointment = (List<AppointmentManager>) jpaApi.em().createNativeQuery("select a.APPOINTMENT_ID, a.PATIENT_ID, a.DOCTOR_ID, d.doc_name, d.DOC_SPECIALTY, a.appointment_date, a.appointment_time, p.first_name from appointment a\n" +
                "join doctor d on a.DOCTOR_ID = d.DOCTOR_ID\n" +
                "join patient p on a.PATIENT_ID = p.PATIENT_ID"+
                " where p.PATIENT_ID = '"+11+"'", AppointmentManager.class).getResultList();

        List<Doctor> doctor = jpaApi.em().createQuery("select d from Doctor d", Doctor.class).getResultList();

        List<Patient> patient = jpaApi.em().createQuery("select p from Patient p", Patient.class).getResultList();

        String ID = request().getQueryString("id");



        if ( ID == null)
        {
            ID ="1";
        }
        Doctor doc = (Doctor) jpaApi.em().createNativeQuery("select doctor_id, DOC_NAME, DOC_ADDRESS, DOC_CITY, DOC_STATE, DOC_ZIP from doctor where doctor_id = :id", Doctor.class).setParameter("id", ID).getSingleResult();

        return ok(views.html.appointmentManagerPage.render(appointment,doctor,patient, doc));
    }

    @Transactional
    public Result deleteAppointment(Long appointmentID)
    {
        Appointment appointments = (Appointment) jpaApi.em().createQuery("select a from Appointment a where a.appointmentID = :ID").setParameter("ID", appointmentID).getSingleResult();
        jpaApi.em().remove(appointments);
        return redirect(routes.AppointmentController.getAppointmentManager());
    }


    @Transactional
    public Result addAppointment()
    {
        String patientID = session("patientID");

        DynamicForm postedForm = formFactory.form().bindFromRequest();
        LocalTime appTime = LocalTime.parse(postedForm.get("time"));
        LocalDate appDate = LocalDate.parse(postedForm.get("date"));
        Long doctorID = Long.parseLong(postedForm.get("doctorID"));

        Appointment appointment = new Appointment();
        appointment.time = appTime;
        appointment.date = appDate;
        appointment.patientID = "11";
        appointment.doctorID = doctorID;
        jpaApi.em().persist(appointment);

        return redirect(routes.AppointmentController.getAppointmentManager());
    }
    @Transactional(readOnly = true)
    public Result getAppointmentEdit(Long appointmentID)
    {
        List<AppointmentManager> appointment = (List<AppointmentManager>) jpaApi.em().createNativeQuery("select a.APPOINTMENT_ID, a.PATIENT_ID, a.DOCTOR_ID, d.doc_name, d.DOC_SPECIALTY, a.appointment_date, a.appointment_time, p.first_name from appointment a\n" +
                "join doctor d on a.DOCTOR_ID = d.DOCTOR_ID\n" +
                "join patient p on a.PATIENT_ID = p.PATIENT_ID"+
                " where p.PATIENT_ID = '"+11+"'", AppointmentManager.class).getResultList();

        List<Patient> patientList = jpaApi.em().createQuery("select p from Patient p", Patient.class).getResultList();

        List<Doctor> doctorList = jpaApi.em().createQuery("select d from Doctor d", Doctor.class).getResultList();



        AppointmentManager currentAppointment = (AppointmentManager) jpaApi.em().createNativeQuery("select a.APPOINTMENT_ID, a.PATIENT_ID, a.DOCTOR_ID, d.doc_name, d.DOC_SPECIALTY, a.appointment_date, a.appointment_time, p.FIRST_NAME from appointment a\n" +
                "join doctor d on a.DOCTOR_ID = d.DOCTOR_ID\n" +
                "join patient p on a.PATIENT_ID = p.PATIENT_ID where a.appointment_ID = :Id", AppointmentManager.class).setParameter("Id", appointmentID).getSingleResult();



        return ok(views.html.editAppointmentPage.render(patientList, doctorList, appointment, currentAppointment));

    }
    @Transactional
    public Result updateAppointment()
    {
        String patientID = session("patientID");

        DynamicForm postedForm = formFactory.form().bindFromRequest();

        LocalTime time = LocalTime.parse(postedForm.get("time"));
        LocalDate date = LocalDate.parse(postedForm.get("date"));
        Long appointmentID = new Long(postedForm.get("appointmentID"));
        Long doctorID = new Long(postedForm.get("doctorID"));

        Appointment appointments = (Appointment) jpaApi.em().createQuery("select ap from Appointment ap where ap.appointmentID = :Id").setParameter("Id", appointmentID).getSingleResult();

        appointments.time = time;
        appointments.date = date;
        appointments.patientID = "11";
        appointments.doctorID = doctorID;
        jpaApi.em().persist(appointments);

        return redirect(routes.AppointmentController.getAppointmentManager());
    }

    @Transactional(readOnly = true)
    public Result getMap(Long doctorID)
    {

            String id = request().getQueryString("id");

            if ( id == null)
            {
                id ="1";
            }
            Doctor doc = (Doctor) jpaApi.em().createNativeQuery("select doctor_id, DOC_NAME, DOC_ADDRESS, DOC_CITY, DOC_STATE, DOC_ZIP, DOC_PHONE_NUMBER, DOC_SPECIALTY from doctor where doctor_id = :id", Doctor.class).setParameter("id", doctorID).getSingleResult();

        List<AppointmentManager> appointment = (List<AppointmentManager>) jpaApi.em().createNativeQuery("select a.APPOINTMENT_ID, a.PATIENT_ID, a.DOCTOR_ID, d.doc_name, d.DOC_SPECIALTY, a.appointment_date, a.appointment_time, p.first_name from appointment a\n" +
                "join doctor d on a.DOCTOR_ID = d.DOCTOR_ID\n" +
                "join patient p on a.PATIENT_ID = p.PATIENT_ID"+
                " where p.PATIENT_ID = '"+11+"'", AppointmentManager.class).getResultList();

        List<Patient> patientList = jpaApi.em().createQuery("select p from Patient p", Patient.class).getResultList();

        List<Doctor> doctorList = jpaApi.em().createQuery("select d from Doctor d", Doctor.class).getResultList();




        return ok(views.html.appointmentManagerMap.render(appointment, doctorList, patientList, doc));
        }
    @Transactional(readOnly = true)
    public Result getEditMap(Long doctorID, Long appointmentID)
    {
        String id = request().getQueryString("id");

        if ( id == null)
        {
            id ="1";
        }
        Doctor doc = (Doctor) jpaApi.em().createNativeQuery("select doctor_id, DOC_NAME, DOC_ADDRESS, DOC_CITY, DOC_STATE, DOC_ZIP, DOC_PHONE_NUMBER, DOC_SPECIALTY from doctor where doctor_id = :DoctorId", Doctor.class).setParameter("DoctorId", doctorID).getSingleResult();

        List<AppointmentManager> appointment = (List<AppointmentManager>) jpaApi.em().createNativeQuery("select a.APPOINTMENT_ID, a.PATIENT_ID, a.DOCTOR_ID, d.doc_name, d.DOC_SPECIALTY, a.appointment_date, a.appointment_time, p.first_name from appointment a\n" +
                "join doctor d on a.DOCTOR_ID = d.DOCTOR_ID\n" +
                "join patient p on a.PATIENT_ID = p.PATIENT_ID"+
                " where p.PATIENT_ID = '"+11+"'", AppointmentManager.class).getResultList();

        List<Patient> patientList = jpaApi.em().createQuery("select p from Patient p", Patient.class).getResultList();

        List<Doctor> doctorList = jpaApi.em().createQuery("select d from Doctor d", Doctor.class).getResultList();

        AppointmentManager currentAppointment = (AppointmentManager) jpaApi.em().createNativeQuery("select a.APPOINTMENT_ID, a.PATIENT_ID, a.DOCTOR_ID, d.doc_name, d.DOC_SPECIALTY, a.appointment_date, a.appointment_time, p.FIRST_NAME from appointment a\n" +
                "join doctor d on a.DOCTOR_ID = d.DOCTOR_ID\n" +
                "join patient p on a.PATIENT_ID = p.PATIENT_ID where a.appointment_ID = :AppointmentId", AppointmentManager.class).setParameter("AppointmentId", appointmentID).getSingleResult();






        return ok(views.html.appoinmentEditMap.render(patientList, doctorList, appointment,currentAppointment, doc));
    }

}
