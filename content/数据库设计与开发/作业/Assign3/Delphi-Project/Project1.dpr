program Project1;

{%File 'Project1.exe.manifest'}

uses
  Forms,
  Unit1 in 'Unit1.pas' {WorkerMainForm},
  Unit2 in 'Unit2.pas' {LoginForm},
  Unit3 in 'Unit3.pas' {AppointmentForm},
  Unit4 in 'Unit4.pas' {NewAppointmentForm},
  Unit5 in 'Unit5.pas' {UserManageForm},
  Unit6 in 'Unit6.pas' {ScheduleManageForm},
  Unit7 in 'Unit7.pas' {NewScheduleForm},
  Unit8 in 'Unit8.pas' {CampusManageForm},
  Unit9 in 'Unit9.pas' {AnnouncementForm};

{$R *.res}

begin
  Application.Initialize;
  // Application.CreateForm(TLoginForm, LoginForm);
  // Application.CreateForm(TWorkerMainForm, WorkerMainForm);
  Application.CreateForm(TLoginForm, LoginForm);
  Application.CreateForm(TWorkerMainForm, WorkerMainForm);
  Application.CreateForm(TAppointmentForm, AppointmentForm);
  Application.CreateForm(TNewAppointmentForm, NewAppointmentForm);
  Application.CreateForm(TUserManageForm, UserManageForm);
  Application.CreateForm(TScheduleManageForm, ScheduleManageForm);
  Application.CreateForm(TNewScheduleForm, NewScheduleForm);
  Application.CreateForm(TCampusManageForm, CampusManageForm);
  Application.CreateForm(TAnnouncementForm, AnnouncementForm);
  // 初始时显示登录窗口，隐藏主窗口
  WorkerMainForm.Hide;
  AppointmentForm.Hide;
  
  Application.Run;
end.
