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
const String getAllJob = '$url/api/rest/issues?page_size=10&page=1';

String getTicketbyId(String issueId) {
  return '$issue/$issueId';
}

String attatchNoteFile(String issueId) {
  return '$issueId/files';
}

String updateIssueStatusById(int issueId) {
  return '$issue/$issueId';
}

String getAttachmentFileById(int issueId, int attachmentId) {
  return '$issue/$issueId/files/$attachmentId';
}

String getUserInfoById(int userId) {
  return '$user/$userId';
}

String createNoteById(int issueId) {
  return '$issue/$issueId/notes';
}

String checkWarrantyBySerial(String serialId) {
  return '$searchProductUrl/$serialId';
}

String usernameProduct = 'VanSale-Dev';
String passwordProduct = 'c8doEpdFC0CFkUWHUEXv';
