const String url = 'https://fsm-dev.vansales.asia';
const String urlFSM = 'http://tscapitest.tmh-wst.com';
const String issue = '$url/api/rest/issues';
const String user = '$url/api/rest/users';
const String loginUrl = '$url/api/rest/users/login';
const String tokenUrl = '$url/api/rest/users/me/token';
const String searchProductUrl = '$urlFSM/api/serial/search';
const String apkUrl =
    'https://drive.google.com/file/d/1TVL378JFqXmkXDe6KdfcOMQXlHhiikHL/view?usp=drive_link';
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

String getWarrantyTruckByTicketId(String issueId) {
  return '$url/api/rest/issues/$issueId/warranty';
}

String getJobBatteryReportById(String id) {
  return '$url/api/rest/jobs/jobs_btr_maintenance_data?job_issue_id=$id';
}

String getPdfPvtReportById(String issueId) {
  return '$url/api/rest/pm_jobs/pdf_pvt/$issueId';
}

String getPdfPvtIcReportById(String issueId) {
  return '$url/api/rest/pm_jobs/pdf_pvt_ic/$issueId';
}

String getPdfBtrReportById(String issueId) {
  return '$url/api/rest/pm_jobs/pdf_btr/$issueId';
}

String getPdfFieldReportById(String issueId) {
  return '$url/api/rest/pm_jobs/pdf_fieldreport/$issueId';
}

String getPdfEstimateReportById(String issueId) {
  return '$url/api/rest/pm_jobs/pdf_estimate/$issueId';
}

String getPdfEstimatePMReportById(String issueId) {
  return '$url/api/rest/pm_jobs/pdf_estimate_pm/$issueId';
}

String getPdfJobsBtrReportById(String issueId) {
  return '$url/api/rest/pm_jobs/pdf_fieldreport_btr/$issueId';
}

String getUserByZone(String zone) {
  return '$url/api/rest/jobs/user_by_zone?zone=$zone';
}

String getAllSales() {
  return '$url/api/rest/jobs/user_all_sales';
}

String getAllSalesAdmin(String id) {
  return '$url/api/rest/jobs/user_all_sales_admin?id=$id';
}

String getAllSalesByIssueIdJobs(String id) {
  return '$url/api/rest/jobs/user_all_sales_jobs?id=$id';
}

String getAllSalesByIssueIdPM(String id) {
  return '$url/api/rest/pm_jobs/user_all_sales_pm?id=$id';
}

String getTrickdetailById(String id) {
  return '$urlFSM/api/serial/search/$id';
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

String createJobsBatteryReport() {
  return '$url/api/rest/jobs/jobs_btr_maintenance_add';
}

String updateJobsBatteryReport() {
  return '$url/api/rest/jobs/jobs_update_btr_maintenance';
}

String createBatteryReport() {
  return '$url/api/rest/pm_jobs/create_btr_maintenance';
}

String updateBatteryReport() {
  return '$url/api/rest/pm_jobs/update_btr_maintenance';
}

String updateJobsBatterySignature() {
  return "$url/api/rest/jobs/jobs_update_btr_maintenance_signature";
}

String createPreventiveReport() {
  return '$url/api/rest/pm_jobs/create_pvt_maintenance';
}

String createPreventiveIcReport() {
  return '$url/api/rest/pm_jobs/create_pvt_maintenance_ic';
}

String updatePreventiveReport() {
  return '$url/api/rest/pm_jobs/update_pvt_maintenance';
}

String updatePreventiveIcReport() {
  return '$url/api/rest/pm_jobs/update_pvt_maintenance_ic';
}

String getPmJobInfoById(String id) {
  return '$url/api/rest/pm_jobs/job_working_details?job_id=$id';
}

String getCustomerBySearch(String id) {
  return '$url/api/rest/users/customer_search/$id';
}

String getPmJobCommentById(String id) {
  return '$url/api/rest/pm_jobs/job_working_comment?job_id=$id';
}

String getPmJobbyId(String id) {
  return '$url/api/rest/pm/get_by_id/$id';
}

String getPmJobPage(String handlerId, int page) {
  return '$url/api/rest/pm/$handlerId/page/$page';
}

String updatePmJobImage() {
  return '$url/api/rest/pm_jobs/update_image_job';
}

String deletePmJobImage() {
  return '$url/api/rest/pm_jobs/delete_image';
}

String updateIssueStatusById(String issueId) {
  return '$issue/$issueId';
}

String updateJobStatusByIdPM() {
  return '$url/api/rest/pm_jobs/update_status_job';
}

String updateTechInfoJob() {
  return '$url/api/rest/issues/update_tech';
}

String updateJobIssueByIdPM() {
  return '$url/api/rest/pm_jobs/update_working';
}

String getAttachmentFileById(int issueId, int attachmentId) {
  return '$issue/$issueId/files/$attachmentId';
}

String getAllAttachmentFile(String issueId) {
  return '$issue/$issueId/files';
}

String getUserInfoById(String userId) {
  return '$user/$userId';
}

String getLatestVersions() {
  return '$url/api/rest/users/versions/get';
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

String getSubJobByIdNew(String subjobId) {
  return '$url/api/rest/jobs/$subjobId/sub_by_id_new';
}

String getSubJobByTicketId(String ticketId) {
  return '$url/api/rest/jobs/$ticketId/getById/';
}

String getPMticketById(String id) {
  return '$url/api/rest/pm?handler_id=$id';
}

String getSubJobsByHandler(String id) {
  return '$url/api/rest/jobs/getByHandlerId?handler_id=$id';
}

String getSparepartJobByHandler(String id) {
  return '$url/api/rest/jobs/getSparepartByHandlerId?handler_id=$id';
}

String getSparepartJobByHandlerNew(String id) {
  return '$url/api/rest/jobs/getSparepartByHandlerIdNew?handler_id=$id';
}

String getSparepartJobById(String id) {
  return '$url/api/rest/jobs/getSparepartByHandlerId?tech_manager_id=$id';
}

String getSparepartJobByIdNew(String id) {
  return '$url/api/rest/jobs/getSparepartByHandlerIdNew?tech_manager_id=$id';
}

String getSubJobsByHandlerPage(String id, int page) {
  return '$url/api/rest/jobs/getByHandlerId/$page?handler_id=$id';
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

String getPreventiveIcReportById(String id) {
  return '$url/api/rest/pm_jobs/pvt_maintenance_ic_data?job_id=$id';
}

String getSparePartbySearch(String partNumber) {
  return '$urlFSM/api/sparepart/search/$partNumber';
}

String getSparePartSearch(String partNumber) {
  return '$url/api/rest/jobs/sparepart/search/$partNumber';
}

String updateBatterySignature() {
  return "$url/api/rest/pm_jobs/update_btr_maintenance_signature";
}

String updatePreventiveSignature() {
  return "$url/api/rest/pm_jobs/update_pvt_maintenance_signature";
}

String updateJobsSignatureUrl() {
  return "$url/api/rest/jobs/jobs_update_signature_url";
}

String updateJobsBatterySignatureUrl() {
  return "$url/api/rest/jobs/jobs_btr_update_signature_url";
}

String updateBatterySignatureUrl() {
  return "$url/api/rest/pm_jobs/btr_update_signature_url";
}

String updatePreventiveSignatureUrl() {
  return "$url/api/rest/pm_jobs/pvt_update_signature_url";
}

String updatePreventiveIcSignatureUrl() {
  return "$url/api/rest/pm_jobs/pvt_ic_update_signature_url";
}

String updateReportById(String id) {
  return "$url/api/rest/jobs/job_report_update?job_issue_id='$id'";
}

String updateSparepart() {
  return "$url/api/rest/jobs/sparepart";
}

String updateJobsSparepartBtr() {
  return "$url/api/rest/jobs/update_jobs_btr_sparepart";
}

String updateSparepartBtr() {
  return "$url/api/rest/pm_jobs/update_btr_sparepart";
}

String updateSparepartPvt() {
  return "$url/api/rest/pm_jobs/update_pvt_sparepart";
}

String updateSparepartPvtIc() {
  return "$url/api/rest/pm_jobs/update_pvt_ic_sparepart";
}

String updateSparepartPM() {
  return "$url/api/rest/pm_jobs/update_pvt_sparepart";
}

String createSparepartNotes() {
  return "$url/api/rest/jobs/sparepart_note";
}

String createHistoryQuotation() {
  return "$url/api/rest/jobs/history_quotation_add";
}

String createUserTokenNotification() {
  return "$url/api/rest/users/create_token_notification";
}

String createJobNotificationHistory() {
  return "$url/api/rest/jobs/job_notification_create";
}

String getJobNotificationHistory(String id) {
  return "$url/api/rest/jobs/get_job_notification_history/$id";
}

String sendUserNotification() {
  return "$url/api/rest/users/rest_user_send_notification";
}

String deleteTokenNotification() {
  return "$url/api/rest/users/logout";
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

String finishedQuote() {
  return '$url/api/rest/jobs/jobs_finished_quote';
}

String createQuotationReport() {
  return '$url/api/rest/jobs/jobs_quotation_create';
}

String createQuotationReportPM() {
  return '$url/api/rest/pm_jobs/jobs_quotation_create_pm';
}

String updateQuotation() {
  return '$url/api/rest/jobs/jobs_quotation_update';
}

String updateQuotationPM() {
  return '$url/api/rest/pm_jobs/jobs_quotation_update_pm';
}

String userDisbled() {
  return '$url/api/rest/users/rest_user_disbled';
}

String getTechReport(String id, String year) {
  return '$url/api/rest/users/tech_user_report/get?handler_id=$id&year=$year';
}

String usernameProduct = 'VanSale-Dev';
String passwordProduct = 'c8doEpdFC0CFkUWHUEXv';
