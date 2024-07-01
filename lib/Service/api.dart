const String url = 'https://fsm-dev.vansales.asia';
const String urlFSM = 'http://tscapi.tmh-wst.com';
const String issue = '$url/api/rest/issues';
const String user = '$url/api/rest/users';
const String loginUrl = '$url/api/rest/users/login';
const String tokenUrl = '$url/api/rest/users/me/token';
const String searchProductUrl = '$urlFSM/api/serial/search';

const String search = '$url/api/rest/users/me/token';

const String getAssignJob =
    '$url/api/rest/issues?filter_id=assigned&page_size=10&page=1';
const String getAllJob = '$url/api/rest/issues?page_size=10&page=2';

String getAllJobs(int page) {
  return '$url/api/rest/issues?page_size=10&page=$page';
}

String getTicketbyId(String issueId) {
  return '$issue/$issueId';
}

String attatchNoteFile(String issueId) {
  return '$issueId/files';
}

String getCustomerInfoById(String customerId) {
  return '$urlFSM/api/customer/search/$customerId';
}

String createPeriodicReport() {
  return '$url/api/rest/pm_jobs/create_pvt_maintenance';
}

String createBatteryReport() {
  return '$url/api/rest/pm_jobs/create_btr_maintenance';
}

String createPreventiveReport() {
  return '$url/api/rest/pm_jobs/create_pvt_maintenance';
}

String updateIssueStatusById(int issueId) {
  return '$issue/$issueId';
}

String getAttachmentFileById(int issueId, int attachmentId) {
  return '$issue/$issueId/files/$attachmentId';
}

String getUserInfoById(String userId) {
  return '$user/$userId';
}

String getUserInfo() {
  return '$user/me';
}

String createNoteById(int issueId) {
  return '$issue/$issueId/notes';
}

String checkWarrantyBySerial(String serialId) {
  return '$searchProductUrl/$serialId';
}

String getAllSubJob() {
  return '$url/api/rest/jobs';
}

String getSubJobById(String subjobId) {
  return '$url/api/rest/jobs/$subjobId/sub_by_id';
}

String getSubJobByTicketId(String ticketId) {
  return '$url/api/rest/jobs/$ticketId/getById/';
}

String getPMticketById(String id) {
  return '$url/api/rest/pm?resource_no=$id';
}

String getSubJobsByHandler(String id) {
  return '$url/api/rest/jobs/getByHandlerId?handler_id=$id';
}

String getRepairReportById(String id) {
  return '$url/api/rest/jobs/jobs_report?id=$id';
}

String getBatteryReportById(String id) {
  return '$url/api/rest/pm_jobs/btr_maintenance_data?job_id=$id';
}

String getPreventiveReportById(String id) {
  return '$url/api/rest/pm_jobs/pvt_maintenance_data?job_id=$id';
}

String updateReportById(String id) {
  return "$url/api/rest/jobs/job_report_update?job_issue_id='$id'";
}

String getAdditionalRepairReportById(String id) {
  return '$url/api/rest/jobs/jobs_report_additional?id=$id';
}

String getPdfById(String issueId) {
  return '$url/api/rest/issues/$issueId/pdf';
}

String createJobReport() {
  return '$url/api/rest/jobs/create_repair_report';
}

String createJobReportAdditional() {
  return '$url/api/rest/jobs/create_repair_report_addition';
}

String getHighRelelationReport() {
  return '$url/api/rest/jobs/high_relation_report';
}

String updateSubJobs(String jobId) {
  return '$url/api/rest/jobs/job_issue_update/$jobId';
}

String usernameProduct = 'VanSale-Dev';
String passwordProduct = 'c8doEpdFC0CFkUWHUEXv';
